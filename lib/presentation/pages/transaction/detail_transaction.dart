import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/styles/app_text_style.dart';
import 'package:raho_mobile/core/utils/helper.dart';
import 'package:raho_mobile/presentation/template/background_white_black.dart';
import 'package:raho_mobile/presentation/widgets/custom_banner.dart';

class DetailTransaction extends StatelessWidget {
  const DetailTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWhiteBlack(
        child: Padding(
          padding: EdgeInsets.only(top: Screen.width * 0.2, left: 12, right: 12),
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
                    "Detail Pembayaran Terapi",
                    textAlign: TextAlign.center,
                    style: AppFontStyle.s18.semibold.white,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
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
                      Container(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: AppColor.black, width: 0.5))),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/logo_raho_crop.png",
                              width: 50,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "RAHO Club",
                                  style: AppFontStyle.s12.bold.primary,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Reverse Aging & Homeostasis Club",
                                  style: AppFontStyle.s10.bold.black,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            width: Screen.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Layanan terapi sudah dilakukan",
                                  style: AppFontStyle.s12.semibold.black,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "29 Juli 2024 12.00 WIB",
                                  style: AppFontStyle.s10.semibold.grey,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Rp 500.000",
                                  style: AppFontStyle.s24.semibold.black,
                                ),
                              ],
                            ),
                          ),
                          CornerBanner(
                            bannerSize: 60,
                            bannerColor: AppColor.green,
                            bannerText: "Terbayar",
                            bannerTextStyle: AppFontStyle.s14.bold.white,
                            child: SizedBox(
                              height: 100,
                              width: Screen.width,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Table(
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                        },
                        children: [
                          _buildRow('Nama Member', 'Mirza Ananta'),
                          _buildRow('Nomor Invoice', 'EBCA/2024/05/0279'),
                          _buildRow('Klinik Cabang', 'RAHO Citraland'),
                          _buildRow('Tanggal', '23/05/2024'),
                          _buildRow('Jenis Terapi', 'Terapi Infus NB-HHO'),
                          _buildRow('Metode Pembayaran', 'EDC - BCA'),
                          _buildRow('Jumlah Voucher', '10'),
                          _buildRow('Free Voucher', '0'),
                          _buildRow('Harga Satuan', 'Rp 500.000'),
                          _buildRow('Total Transaksi', 'Rp 5.000.000'),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.download,
                                      color: AppColor.black,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Unduh",
                                      style: AppFontStyle.s12.regular.black,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color: AppColor.grey, width: 0.5))),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.share,
                                      color: AppColor.black,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Bagikan",
                                      style: AppFontStyle.s12.regular.black,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColor.white,
                              border: Border.all(color: AppColor.black)),
                          child: Text(
                            "Lihat Redeem Voucher",
                            style: AppFontStyle.s16.bold.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  TableRow _buildRow(String label, String value) {
    return TableRow(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            label,
            style: AppFontStyle.s12.regular.grey,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.only(right: 16),
          child: Text(
            value,
            style: AppFontStyle.s12.semibold.black,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
