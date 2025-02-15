import 'package:flutter/material.dart';
import 'package:raho_mobile/core/styles/app_color.dart';

class Loading {
  final BuildContext context;
  bool _isShowing = false;

  Loading({required this.context});

  void show() {
    if (!_isShowing) {
      _isShowing = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: AppColor.primary,
          ),
        ),
      );
    }
  }

  void dismiss() {
    if (_isShowing) {
      _isShowing = false;
      Navigator.of(context,rootNavigator: true).pop();
    }
  }
}
