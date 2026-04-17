import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Convert Base64 to Image bytes
  Uint8List base64ToImage(String base64String) {
    return base64Decode(base64String);
  }

  /// Chech if the User is Logged In
  bool isUserLoggedIn() {
    return _auth.currentUser != null;
  }

  /// Get User ID
  String? getUserId() {
    return _auth.currentUser?.uid;
  }

  /// CREATE
  Future<void> create({
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection(collection).add(data);
  }

  /// READ ALL
  Future<List<QueryDocumentSnapshot>> readAll(String collection) async {
    QuerySnapshot snapshot = await _firestore.collection(collection).get();

    return snapshot.docs;
  }

  /// READ ONE
  Future<DocumentSnapshot> readOne({
    required String collection,
    required String id,
  }) async {
    return await _firestore.collection(collection).doc(id).get();
  }

  /// Read Image
  Future<Uint8List?> readImage(String userId, String collection) async {
    var doc = await _firestore.collection(collection).doc(userId).get();

    if (!doc.exists) return null;

    String base64Image = doc["photo"];

    return base64Decode(base64Image);
  }

  /// UPDATE
  Future<void> update({
    required String collection,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection(collection).doc(id).update(data);
  }

  /// DELETE
  Future<void> delete({required String collection, required String id}) async {
    await _firestore.collection(collection).doc(id).delete();
  }
}
