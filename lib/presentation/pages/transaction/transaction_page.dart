import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_mobile/core/constants/route_constant.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/styles/app_text_style.dart';
import 'package:raho_mobile/core/utils/helper.dart';
import 'package:raho_mobile/presentation/template/background_white_black.dart';
import 'package:raho_mobile/presentation/widgets/custom_dropdown.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWhiteBlack(
        child: Padding(
      padding: EdgeInsets.only(
        top: Screen.width * 0.2,
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 24, left: 24, right: 24),
            width: Screen.width,
            alignment: Alignment.center,
            child: Text(
              "Riwayat Transaksi Anda",
              textAlign: TextAlign.center,
              style: AppFontStyle.s20.semibold.white,
            ),
          ),
          Expanded(
              child: Container(
            color: AppColor.white,
            padding: const EdgeInsets.only(top: 16),
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
                        margin: const EdgeInsets.only(left: 16),
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
                              Icons.account_balance_wallet,
                              color: AppColor.black,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Jenis Transaksi",
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
                        margin: const EdgeInsets.only(right: 16),
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
                  height: 24,
                ),
                Expanded(
                    child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Transaksi Layanan Terapi",
                            style: AppFontStyle.s16.bold.black,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColor.black,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    GestureDetector(
                      onTap: () => context.push(RouteApp.detailTransaction),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: AppColor.grey))),
                        child: Row(
                          children: [
                            Container(
                              height: 42,
                              width: 42,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColor.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                FontAwesomeIcons.heartPulse,
                                color: AppColor.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "INV/2024/07/1252",
                                  style: AppFontStyle.s10.regular.black,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Infus NB-HHO (20 ml)",
                                  style: AppFontStyle.s14.bold.black,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("29 Juli 2024",
                                    style: AppFontStyle.s12.regular.grey),
                              ],
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "-Rp 1.500.000",
                              style: AppFontStyle.s11.semibold.black,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: AppColor.grey))),
                      child: Row(
                        children: [
                          Container(
                            height: 42,
                            width: 42,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColor.orange,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.ticketSimple,
                                  color: AppColor.white,
                                ),
                                Icon(
                                  FontAwesomeIcons.percent,
                                  size: 16,
                                  color: AppColor.orange,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "INV/2024/07/1252",
                                style: AppFontStyle.s10.regular.black,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Infus NB-HHO (20 ml)",
                                style: AppFontStyle.s14.bold.black,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("29 Juli 2024",
                                  style: AppFontStyle.s12.regular.grey),
                            ],
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "-Rp 1.000.000",
                            style: AppFontStyle.s11.semibold.black,
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: AppColor.grey))),
                      child: Row(
                        children: [
                          Container(
                            height: 42,
                            width: 42,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              FontAwesomeIcons.heartPulse,
                              color: AppColor.white,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "INV/2024/07/1252",
                                style: AppFontStyle.s10.regular.black,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Infus NB-HHO (20 ml)",
                                style: AppFontStyle.s14.bold.black,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("29 Juli 2024",
                                  style: AppFontStyle.s12.regular.grey),
                            ],
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "-Rp 1.500.000",
                            style: AppFontStyle.s11.semibold.black,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pembayaran Layanan Terapi",
                            style: AppFontStyle.s16.bold.black,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColor.black,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: AppColor.grey))),
                      child: Row(
                        children: [
                          Container(
                            height: 42,
                            width: 42,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColor.gold,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              FontAwesomeIcons.solidCreditCard,
                              color: AppColor.white,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "EBCA/2024/05/0280",
                                  style: AppFontStyle.s10.regular.black,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Pembayaran Terapi Infus NO++",
                                  style: AppFontStyle.s14.bold.black,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("29 Juli 2024",
                                    style: AppFontStyle.s12.regular.grey),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Rp 750.000",
                            style: AppFontStyle.s11.semibold.black,
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: AppColor.grey))),
                      child: Row(
                        children: [
                          Container(
                            height: 42,
                            width: 42,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColor.gold,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              FontAwesomeIcons.solidCreditCard,
                              color: AppColor.white,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "EBCA/2024/05/0280",
                                  style: AppFontStyle.s10.regular.black,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Pembayaran Terapi Infus NB-HHO",
                                  style: AppFontStyle.s14.bold.black,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("29 Juli 2024",
                                    style: AppFontStyle.s12.regular.grey),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Rp 5.000.000",
                            style: AppFontStyle.s11.semibold.black,
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: AppColor.grey))),
                      child: Row(
                        children: [
                          Container(
                            height: 42,
                            width: 42,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColor.gold,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              FontAwesomeIcons.solidCreditCard,
                              color: AppColor.white,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "EBCA/2024/05/0280",
                                  style: AppFontStyle.s10.regular.black,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Pembayaran Terapi Infus NB-HHO",
                                  style: AppFontStyle.s14.bold.black,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("29 Juli 2024",
                                    style: AppFontStyle.s12.regular.grey),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Rp 5.000.000",
                            style: AppFontStyle.s11.semibold.black,
                          )
                        ],
                      ),
                    )
                  ],
                )),
              ],
            ),
          )),
        ],
      ),
    ));
    ;
  }
}
