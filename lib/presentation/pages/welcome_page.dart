import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_mobile/core/constants/app_constant.dart';
import 'package:raho_mobile/core/constants/route_constant.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/styles/app_text_style.dart';
import 'package:raho_mobile/core/utils/helper.dart';
import 'package:raho_mobile/data/services/welcome_to_app.dart';

class WelcomePage extends StatelessWidget {
  final WelcomeService service;

  const WelcomePage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/family.png",
            width: Screen.width,
            height: Screen.height,
            fit: BoxFit.cover,
          ),
          Container(
            width: Screen.width,
            height: Screen.height,
            color: AppColor.black.withValues(alpha: 0.3, red: 200),
          ),
          Column(
            children: [
              Expanded(child: Container()),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                    color: AppColor.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppConstant.CORPORATE_NAME,
                      style: AppFontStyle.s32.bold.black,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      AppConstant.GREETING_TEXT,
                      style: AppFontStyle.s15.light.black,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    GestureDetector(
                        onTap: () {
                          service.saveKey(1);
                          context.go(RouteApp.login);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          width: Screen.width,
                          decoration: BoxDecoration(
                              color: AppColor.black2,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "Masuk",
                            style: AppFontStyle.s16.bold.white,
                          ),
                        )),
                    const SizedBox(
                      height: 12,
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
