import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:labsense_ai/core/services/firebase_service.dart';
import 'package:labsense_ai/model/user_model.dart';

class HomeController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();

  /// user model
  var user = Rxn<UserModel>();

  /// image
  var profileImage = Rxn<Uint8List>();

  /// Loading state
  var isLoading = false.obs;

  /// Load user data
  Future<void> loadUserData() async {
    try {
      isLoading.value = true;

      String? userId = _firebaseService.getUserId();

      if (userId == null) return;

      var doc = await _firebaseService.readOne(collection: "users", id: userId);

      if (!doc.exists) return;

      final userModel = UserModel.fromMap(
        doc.data() as Map<String, dynamic>,
        doc.id,
      );

      user.value = userModel;

      /// Decode image
      if (userModel.photoBase64.isNotEmpty) {
        profileImage.value = base64Decode(userModel.photoBase64);
      }
    } catch (e) {
      print("Error loading user: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() async {
    await loadUserData();
    super.onInit();
  }
}
