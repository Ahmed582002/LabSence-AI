import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseErrors {
  static String getAuthErrorMessage(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-email':
          return '49'.tr;

        case 'invalid-credential':
          return '50'.tr;

        case 'user-not-found':
          return '51'.tr;

        case 'wrong-password':
          return '52'.tr;

        case 'email-already-in-use':
          return '53'.tr;

        case 'weak-password':
          return '54'.tr;

        case 'network-request-failed':
          return '55'.tr;

        case 'too-many-requests':
          return '56'.tr;

        default:
          return '57'.tr;
      }
    }

    return 'Unexpected error occurred.';
  }

  static String getFirestoreErrorMessage(dynamic error) {
    if (error is FirebaseException) {
      switch (error.code) {
        case 'permission-denied':
          return '58'.tr;

        case 'unavailable':
          return '59'.tr;

        default:
          return 'Database error occurred.';
      }
    }

    return 'Unexpected error occurred.';
  }
}
