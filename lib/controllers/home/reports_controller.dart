import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/core/services/firebase_service.dart';

class ReportsController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseService firebaseService = FirebaseService();

  RxList<QueryDocumentSnapshot<Map<String, dynamic>>> reports =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  RxList<QueryDocumentSnapshot<Map<String, dynamic>>> filteredReports =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  var isLoading = false.obs;

  TextEditingController searchController = TextEditingController();

  Future<void> fetchReports() async {
    try {
      isLoading.value = true;

      final userId = firebaseService.getUserId();

      final snapshot = await firestore
          .collection("history")
          .doc(userId)
          .collection("reports")
          .orderBy("createdAt", descending: true)
          .get();

      reports.value = snapshot.docs;

      // show all reports initially
      filteredReports.value = snapshot.docs;
    } catch (e) {
      print("Error loading reports: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void searchReports(String value) {
    if (value.trim().isEmpty) {
      filteredReports.value = reports;
      return;
    }

    filteredReports.value = reports.where((doc) {
      final data = doc.data();

      final testName = (data["test_name"] ?? "").toString().toLowerCase();

      return testName.contains(value.toLowerCase());
    }).toList();
  }

  List<FlSpot> getHealthScoreSpots() {
    if (filteredReports.isEmpty) return [];

    final reversed = filteredReports.reversed.toList();

    return List.generate(reversed.length, (index) {
      final doc = reversed[index];
      final data = doc.data();

      final score = (data["health_score"] ?? 0).toDouble();

      return FlSpot(index.toDouble(), score);
    });
  }

  Future<void> deleteReport(String reportId) async {
    try {
      final userId = firebaseService.getUserId();

      await firestore
          .collection("history")
          .doc(userId)
          .collection("reports")
          .doc(reportId)
          .delete();

      // update UI instantly
      reports.removeWhere((doc) => doc.id == reportId);

      filteredReports.removeWhere((doc) => doc.id == reportId);

      Get.snackbar(
        "Done",
        "Deleted successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to delete report",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onInit() {
    fetchReports();
    searchController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
