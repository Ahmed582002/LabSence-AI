import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/controllers/auth/state/auth_state.dart';

class StateBuilder extends StatelessWidget {
  final Rx<AuthState> state;

  final Function()? onIdle;
  final Function()? onLoading;
  final Function()? onSuccess;
  final Function(String message)? onError;

  final String? errorMessage;

  const StateBuilder({
    super.key,
    required this.state,
    this.onIdle,
    this.onLoading,
    this.onSuccess,
    this.onError,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (state.value) {
        case AuthState.loading:
          return onLoading?.call() ??
              const Center(child: CircularProgressIndicator());

        case AuthState.success:
          return onSuccess?.call() ?? const SizedBox();

        case AuthState.error:
          return onError?.call(errorMessage ?? "Something went wrong") ??
              Center(child: Text(errorMessage ?? "Error"));

        // case AuthState.idle:
        default:
          return onIdle?.call() ?? const SizedBox();
      }
    });
  }
}
