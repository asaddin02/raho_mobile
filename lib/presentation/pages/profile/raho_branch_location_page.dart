import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/styles/app_text_style.dart';
import 'package:raho_mobile/core/utils/helper.dart';
import 'package:raho_mobile/presentation/template/background_white_black.dart';

class RahoBranchLocationPage extends StatelessWidget {
  const RahoBranchLocationPage({super.key});

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
                    "Lokasi Cabang Raho",
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
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 36,
                        width: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.location_on,
                          size: 20,
                          color: AppColor.white,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: AppColor.grey))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Raho Cabang Balikpapan",
                                style: AppFontStyle.s16.bold.black,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Komplek Ruko, Jl. MT Haryono, Jl. Citra City "
                                "blok SH No.9, Kota Balikpapan, Kalimantan Timur",
                                style: AppFontStyle.s12.regular.black,
                                maxLines: 2,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 36,
                        width: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.location_on,
                          size: 20,
                          color: AppColor.white,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: AppColor.grey))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Raho Cabang Balikpapan",
                                style: AppFontStyle.s16.bold.black,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Komplek Ruko, Jl. MT Haryono, Jl. Citra City "
                                "blok SH No.9, Kota Balikpapan, Kalimantan Timur",
                                style: AppFontStyle.s12.regular.black,
                                maxLines: 2,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
    ;
  }
}
