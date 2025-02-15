import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_mobile/bloc/history/history_bloc.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/styles/app_text_style.dart';
import 'package:raho_mobile/core/utils/helper.dart';
import 'package:raho_mobile/presentation/template/background_white_black.dart';

class DetailHistoryPage extends StatefulWidget {
  final int historyId;

  const DetailHistoryPage({super.key, required this.historyId});

  @override
  State<DetailHistoryPage> createState() => _DetailHistoryPageState();
}

class _DetailHistoryPageState extends State<DetailHistoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<HistoryBloc>()
          .add(FetchDetailHistory(historyId: widget.historyId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWhiteBlack(
        child: Padding(
      padding: EdgeInsets.only(top: 48),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 24, left: 36, right: 36),
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
                    "Rincian Terapi",
                    textAlign: TextAlign.center,
                    style: AppFontStyle.s20.semibold.white,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              width: Screen.width,
              color: AppColor.white,
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/images/person.jpg"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Table(
                              columnWidths: {
                                0: FlexColumnWidth(1.4),
                                1: FlexColumnWidth(0.2),
                                2: FlexColumnWidth(3.4),
                              },
                              children: [
                                _buildRow("Member", "Mirza Ananta",
                                    separator: ":"),
                                _buildRow("Tanggal", "24/04/2024",
                                    separator: ":"),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 120,
                                padding: EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                    color: AppColor.primary,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.play_arrow_rounded,
                                      color: AppColor.white,
                                    ),
                                    Text(
                                      "Start Survey",
                                      style: AppFontStyle.s10.regular.white,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                              color: AppColor.grey3,
                              borderRadius: BorderRadius.circular(16)),
                          child: Text(
                            "Riwayat Terapi",
                            style: AppFontStyle.s12.semibold.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                              color: AppColor.grey2,
                              borderRadius: BorderRadius.circular(16)),
                          child: Text(
                            "Riwayat Survey",
                            style: AppFontStyle.s12.semibold.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Table(
                    columnWidths: {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(3)
                    },
                    children: [
                      _buildRow("Infus ke", "1"),
                      _buildRow("Jenis Infus", "[IFA+MG] Infus A+Mg"),
                      _buildRow("Tgl. Produksi", "03/02/2024"),
                      _buildRow("Infus berikutnya", "27/02/2024"),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Healing Crisis",
                    style: AppFontStyle.s12.bold.black,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Keluhan Healing Crisis",
                    style: AppFontStyle.s12.regular.black,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    maxLines: 2,
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
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Catatan/Tindakan",
                    style: AppFontStyle.s12.regular.black,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    maxLines: 2,
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
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Penggunaan Jarum",
                    style: AppFontStyle.s12.bold.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.grey2, width: 0.5),
                        borderRadius: BorderRadius.circular(12)),
                    child: Table(
                      border:
                          TableBorder(borderRadius: BorderRadius.circular(12)),
                      columnWidths: {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                      },
                      children: [
                        _buildTable(
                            value1: "Jarum",
                            value2: "Nakes",
                            value3: "Status",
                            color: AppColor.grey2.withValues(alpha: 0.2),
                            radius: BorderRadius.vertical(
                                top: Radius.circular(12))),
                        _buildTable(),
                        _buildTable(
                            color: AppColor.grey2.withValues(alpha: 0.2),
                            radius: BorderRadius.vertical(
                                bottom: Radius.circular(12))),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                              color: AppColor.grey3,
                              borderRadius: BorderRadius.circular(16)),
                          child: Text(
                            "Anamnesis",
                            style: AppFontStyle.s12.semibold.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                              color: AppColor.grey2,
                              borderRadius: BorderRadius.circular(16)),
                          child: Text(
                            "Foto Lab",
                            style: AppFontStyle.s12.semibold.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Keluhan Setelah Terapi",
                    style: AppFontStyle.s12.regular.black,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    maxLines: 2,
                    style: AppFontStyle.s12.regular.black,
                    decoration: InputDecoration(
                      hintStyle: AppFontStyle.s12.semibold.grey,
                      hintText: "Tidak Ada Keluhan",
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Keluhan Sebelum Terapi",
                    style: AppFontStyle.s12.regular.black,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    maxLines: 2,
                    style: AppFontStyle.s12.regular.black,
                    decoration: InputDecoration(
                      hintStyle: AppFontStyle.s12.semibold.grey,
                      hintText: "Tidak Ada Keluhan",
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
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tekanan Darah",
                    style: AppFontStyle.s12.bold.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Table(
                          columnWidths: {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(0.5),
                          },
                          children: [
                            _buildRow("Sis. Sebelum", "120.00"),
                            _buildRow("Sis. Sebelum", "117.00")
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Table(
                          columnWidths: {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(0.5),
                          },
                          children: [
                            _buildRow("Dias. Sebelum", "120.00",
                                align2: Alignment.centerRight),
                            _buildRow("Dias. Sebelum", "117.00",
                                align2: Alignment.centerRight)
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Saturasi 02",
                    style: AppFontStyle.s12.bold.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Table(
                    columnWidths: {
                      0: FlexColumnWidth(0.7),
                      1: FlexColumnWidth(0.3),
                    },
                    children: [
                      _buildRow("Saturasi Sebelum", "99,00",
                          align2: Alignment.centerRight),
                      _buildRow("Saturasi Sesudah", "99,00",
                          align2: Alignment.centerRight),
                      _buildRow("Index Perfusi Sebelum", "120,00",
                          align2: Alignment.centerRight),
                      _buildRow("Index Perfusi Sesudah", "117,00",
                          align2: Alignment.centerRight),
                      _buildRow("HR Sebelum", "97,00",
                          align2: Alignment.centerRight),
                      _buildRow("HR Sesudah", "87,00",
                          align2: Alignment.centerRight),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  TableRow _buildRow(String label, String value,
      {String? separator,
      Alignment align1 = Alignment.centerLeft,
      Alignment align2 = Alignment.centerLeft}) {
    return TableRow(
      children: [
        Container(
          alignment: align1,
          margin: EdgeInsets.only(bottom: 5),
          child: Text(
            label,
            style: AppFontStyle.s12.regular.black,
          ),
        ),
        if (separator != null)
          Text(
            separator,
            style: AppFontStyle.s12.regular.black,
          ),
        Container(
          alignment: align2,
          margin: EdgeInsets.only(bottom: 5),
          child: Text(
            value,
            style: AppFontStyle.s12.semibold.grey,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  TableRow _buildTable(
      {String? value1,
      String? value2,
      String? value3,
      Color? color,
      BorderRadius? radius}) {
    return TableRow(
        decoration: BoxDecoration(color: color, borderRadius: radius),
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            height: 40,
            alignment: Alignment.center,
            child: Text(
              value1 ?? "",
              style: AppFontStyle.s12.semibold.black,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            height: 40,
            alignment: Alignment.center,
            child: Text(
              value2 ?? "",
              style: AppFontStyle.s12.semibold.black,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            height: 40,
            alignment: Alignment.center,
            child: Text(
              value3 ?? "",
              style: AppFontStyle.s12.semibold.black,
            ),
          )
        ]);
  }
}
