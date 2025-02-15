import 'package:flutter/material.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/utils/helper.dart';

class BackgroundWhiteBlack extends StatelessWidget {
  final Widget child;

  const BackgroundWhiteBlack({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            color: AppColor.black,
            height: Screen.height * 0.275,
          ),
          child
        ],
      ),
    );
  }
}
