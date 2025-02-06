import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/styles/app_text_style.dart';

class Toast {
  void showToast(BuildContext context,
      {required String title, required String message}) {
    FToast fToast = FToast();
    fToast.init(context);
    Widget toast = Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: AppColor.black.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning_amber, color: AppColor.white, size: 30),
            SizedBox(height: 8),
            Text(title, style: AppFontStyle.s14.semibold.white),
            SizedBox(height: 4),
            Text(
              message,
              style: AppFontStyle.s12.regular.white,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );

    fToast.showToast(
        child: toast,
        toastDuration: const Duration(seconds: 3),
        gravity: ToastGravity.CENTER);
  }
}
