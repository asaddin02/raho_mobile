import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raho_mobile/bloc/auth/auth_bloc.dart';
import 'package:raho_mobile/core/constants/route_constant.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/styles/app_text_style.dart';
import 'package:raho_mobile/core/utils/helper.dart';

class LogoutPopUp extends StatelessWidget {
  const LogoutPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        padding: EdgeInsets.all(16),
        width: Screen.width * 0.8,
        decoration: BoxDecoration(
            color: AppColor.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/logo_raho.png",
              width: 150,
            ),
            Text(
              "Apakah Anda yakin ingin keluar dari aplikasi?",
              textAlign: TextAlign.center,
              style: AppFontStyle.s14.regular.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Text(
                    "Batal",
                    style: AppFontStyle.s14.bold.primary,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<AuthBloc>().add(LogoutRequested());
                    clearAndNavigate(RouteApp.splash, context);
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColor.primary),
                      child: Text(
                        "Keluar",
                        style: AppFontStyle.s14.bold.white,
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
