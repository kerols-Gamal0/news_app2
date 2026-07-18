import 'package:flutter/material.dart';
import 'base_state.dart';

class BaseStateBuilder<T> extends StatelessWidget {
  final BaseState<T> state;
  final Widget Function(T data) onSuccess;
  final Widget Function(String error)? onFailure;
  final Widget? onLoading;
  final Widget? onInitial;

  const BaseStateBuilder({
    super.key,
    required this.state,
    required this.onSuccess,
    this.onFailure,
    this.onLoading,
    this.onInitial,
  });

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      BaseInitialState() => onInitial ?? const SizedBox.shrink(),

      BaseLoadingState() =>
        onLoading ??
            const Center(
              child: CircularProgressIndicator(color: Color(0xff1877F2)),
            ),

      BaseFailureState(errorMessage: final msg) =>
        onFailure != null
            ? onFailure!(msg)
            : Center(
                child: Text(
                  msg,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),

      BaseSuccessState(data: final data) => onSuccess(data),
    };
  }
}
