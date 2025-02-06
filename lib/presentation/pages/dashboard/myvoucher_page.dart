import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/styles/app_text_style.dart';
import 'package:raho_mobile/core/utils/helper.dart';
import 'package:raho_mobile/presentation/template/background_white_black.dart';
import 'package:raho_mobile/presentation/widgets/custom_dropdown.dart';
import 'package:raho_mobile/presentation/widgets/dotted_border.dart';
import 'package:raho_mobile/presentation/widgets/half_circle.dart';

class MyVoucherPage extends StatelessWidget {
  const MyVoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWhiteBlack(
        child: Padding(
      padding: EdgeInsets.only(top: 48),
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
                    "Voucher Anda",
                    textAlign: TextAlign.center,
                    style: AppFontStyle.s20.semibold.white,
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            color: AppColor.white,
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomDropdown(
                      items: ["Semua Voucher", "Terpakai", "Belum Terpakai"],
                      onSelect: (value) {
                        print(value);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColor.black.withValues(alpha: 0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2)
                            ]),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.tickets_fill,
                              color: AppColor.black,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Status Voucher",
                              style: AppFontStyle.s12.regular.black,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColor.black,
                            )
                          ],
                        ),
                      ),
                    ),
                    CustomDropdown(
                      items: [
                        "Semua Tanggal",
                        "Hari Ini",
                        "7 Hari Terakhir",
                        "30 Hari Terakhir",
                        "60 Hari Terakhir",
                        "9- Hari Terakhir"
                      ],
                      onSelect: (value) {
                        print(value);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColor.black.withValues(alpha: 0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2)
                            ]),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: AppColor.black,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Pilih Tanggal",
                              style: AppFontStyle.s12.regular.black,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Agustus 2024",
                    style: AppFontStyle.s16.semibold.black,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                    child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: AppColor.black.withValues(alpha: 0.3),
                                spreadRadius: 0,
                                blurRadius: 2,
                                offset: Offset(0, 4))
                          ]),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "5e1bc952-6e6c-4218-be3",
                                  style: AppFontStyle.s14.bold.white,
                                ),
                                Text(
                                  "Paket Infus 10x",
                                  style: AppFontStyle.s12.regular.grey,
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              HalfCircle(
                                width: 10,
                                height: 20,
                                color: AppColor.white,
                                isLeftSide: false,
                              ),
                              Expanded(
                                child: DottedBorder(
                                    color: AppColor.white,
                                    strokeWidth: 2,
                                    gap: 5,
                                    child: SizedBox(
                                      width: double.infinity,
                                    )),
                              ),
                              HalfCircle(
                                width: 10,
                                height: 20,
                                color: AppColor.white,
                                isLeftSide: true,
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tanggal Redeem : 07 Aug 2024",
                                  style: AppFontStyle.s12.regular.white,
                                ),
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color:
                                          AppColor.primary.withValues(red: 150),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColor.black
                                                .withValues(alpha: 0.1),
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: Offset(0, 2))
                                      ]),
                                  child: Text(
                                    "Terpakai",
                                    style: AppFontStyle.s12.bold.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: AppColor.black.withValues(alpha: 0.3),
                                spreadRadius: 0,
                                blurRadius: 2,
                                offset: Offset(0, 4))
                          ]),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "5e1bc952-6e6c-4218-be3",
                                  style: AppFontStyle.s14.bold.white,
                                ),
                                Text(
                                  "Paket Infus 10x",
                                  style: AppFontStyle.s12.regular.grey,
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              HalfCircle(
                                width: 10,
                                height: 20,
                                color: AppColor.white,
                                isLeftSide: false,
                              ),
                              Expanded(
                                child: DottedBorder(
                                    color: AppColor.white,
                                    strokeWidth: 2,
                                    gap: 5,
                                    child: SizedBox(
                                      width: double.infinity,
                                    )),
                              ),
                              HalfCircle(
                                width: 10,
                                height: 20,
                                color: AppColor.white,
                                isLeftSide: true,
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: AppColor.grey2,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColor.black
                                                .withValues(alpha: 0.1),
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: Offset(0, 2))
                                      ]),
                                  child: Text(
                                    "Belum Terpakai",
                                    style: AppFontStyle.s12.bold.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: AppColor.black.withValues(alpha: 0.3),
                                spreadRadius: 0,
                                blurRadius: 2,
                                offset: Offset(0, 4))
                          ]),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "5e1bc952-6e6c-4218-be3",
                                  style: AppFontStyle.s14.bold.white,
                                ),
                                Text(
                                  "Paket Infus 10x",
                                  style: AppFontStyle.s12.regular.grey,
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              HalfCircle(
                                width: 10,
                                height: 20,
                                color: AppColor.white,
                                isLeftSide: false,
                              ),
                              Expanded(
                                child: DottedBorder(
                                    color: AppColor.white,
                                    strokeWidth: 2,
                                    gap: 5,
                                    child: SizedBox(
                                      width: double.infinity,
                                    )),
                              ),
                              HalfCircle(
                                width: 10,
                                height: 20,
                                color: AppColor.white,
                                isLeftSide: true,
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tanggal Redeem : 07 Aug 2024",
                                  style: AppFontStyle.s12.regular.white,
                                ),
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color:
                                          AppColor.primary.withValues(red: 150),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColor.black
                                                .withValues(alpha: 0.1),
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: Offset(0, 2))
                                      ]),
                                  child: Text(
                                    "Terpakai",
                                    style: AppFontStyle.s12.bold.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: AppColor.black.withValues(alpha: 0.3),
                                spreadRadius: 0,
                                blurRadius: 2,
                                offset: Offset(0, 4))
                          ]),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "5e1bc952-6e6c-4218-be3",
                                  style: AppFontStyle.s14.bold.white,
                                ),
                                Text(
                                  "Paket Infus 10x",
                                  style: AppFontStyle.s12.regular.grey,
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              HalfCircle(
                                width: 10,
                                height: 20,
                                color: AppColor.white,
                                isLeftSide: false,
                              ),
                              Expanded(
                                child: DottedBorder(
                                    color: AppColor.white,
                                    strokeWidth: 2,
                                    gap: 5,
                                    child: SizedBox(
                                      width: double.infinity,
                                    )),
                              ),
                              HalfCircle(
                                width: 10,
                                height: 20,
                                color: AppColor.white,
                                isLeftSide: true,
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: AppColor.grey2,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColor.black
                                                .withValues(alpha: 0.1),
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: Offset(0, 2))
                                      ]),
                                  child: Text(
                                    "Belum Terpakai",
                                    style: AppFontStyle.s12.bold.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ))
              ],
            ),
          )),
        ],
      ),
    ));
  }
}
