import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/styles/app_text_style.dart';
import 'package:raho_mobile/core/utils/helper.dart';
import 'package:raho_mobile/presentation/template/background_white_black.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWhiteBlack(
        child: Padding(
      padding: EdgeInsets.only(top: Screen.width * 0.2, left: 12, right: 12),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20, left: 24, right: 24),
            alignment: Alignment.center,
            width: Screen.width,
            child: Text(
              "Riwayat Terapi Anda",
              textAlign: TextAlign.center,
              style: AppFontStyle.s20.semibold.white,
            ),
          ),
          Container(
            width: Screen.width,
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.only(bottom: 64),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: AppColor.white),
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      "Terapi",
                      style: AppFontStyle.s12.semibold.white,
                    ),
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      "Lab",
                      style: AppFontStyle.s12.semibold.white,
                    ),
                  ),
                ))
              ],
            ),
          ),
          TextFormField(
            style: AppFontStyle.s12.regular.black,
            decoration: InputDecoration(
                filled: true,
                isDense: true,
                fillColor: AppColor.grey2,
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 25,
                    height: 25,
                    margin: EdgeInsets.all(4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          FontAwesomeIcons.sliders,
                          color: AppColor.black,
                          size: 16,
                        )),
                  ),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColor.grey3,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColor.grey2)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColor.grey2)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColor.grey2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColor.grey2)),
                hintText: "Cari",
                hintStyle: AppFontStyle.s12.regular.grey3),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: 100,
                  width: Screen.width,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColor.white,
                      boxShadow: [
                        BoxShadow(
                            color: AppColor.black.withValues(alpha: 0.1),
                            blurRadius: 2,
                            spreadRadius: 1,
                            offset: Offset(0, 1))
                      ]),
                  child: Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.syringe,
                          color: AppColor.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "A+MG NB 20 ML",
                              style: AppFontStyle.s12.semibold.black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Raho Citraland",
                                      style: AppFontStyle.s12.regular.primary,
                                    ),
                                    Text(
                                      "20/03/2024",
                                      style: AppFontStyle.s10.semibold.black,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Infus ke-15",
                                      style: AppFontStyle.s12.regular.black,
                                    ),
                                    Text(
                                      "Windi - CTRL",
                                      style: AppFontStyle.s10.semibold.black,
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
    ;
  }
}
