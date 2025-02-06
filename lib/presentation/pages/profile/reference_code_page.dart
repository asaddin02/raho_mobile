import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/styles/app_text_style.dart';
import 'package:raho_mobile/core/utils/helper.dart';
import 'package:raho_mobile/presentation/template/background_white_black.dart';

class ReferenceCodePage extends StatelessWidget {
  const ReferenceCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWhiteBlack(
        child: Padding(
          padding: EdgeInsets.only(top: 48, left: 12, right: 12),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 24, left: 24, right: 24),
                width: Screen.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColor.white,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Kode Referensi",
                        textAlign: TextAlign.center,
                        style: AppFontStyle.s20.semibold.white,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  width: Screen.width,
                  margin: EdgeInsets.only(bottom: 12, left: 4, right: 4),
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.black.withValues(alpha: 0.3),
                          spreadRadius: 2,
                          blurRadius: 2,
                        )
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Referal",
                        style: AppFontStyle.s14.semibold.black,
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        style: AppFontStyle.s12.regular.black,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: AppColor.grey)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: AppColor.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: AppColor.grey)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Nomor Kartu",
                        style: AppFontStyle.s14.semibold.black,
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        style: AppFontStyle.s12.regular.black,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: AppColor.grey)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: AppColor.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: AppColor.grey)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Nama Referal",
                        style: AppFontStyle.s14.semibold.black,
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        style: AppFontStyle.s12.regular.black,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: AppColor.grey)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: AppColor.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: AppColor.grey)),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));;
  }
}
