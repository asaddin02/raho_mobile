import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_mobile/bloc/history/history_bloc.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/styles/app_text_style.dart';
import 'package:raho_mobile/core/utils/helper.dart';
import 'package:raho_mobile/core/utils/loading.dart';
import 'package:raho_mobile/presentation/template/background_white_black.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void dispose() {
    context.read<HistoryBloc>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Loading loading = Loading(context: context);
    return BlocConsumer<HistoryBloc, HistoryState>(
      listener: (context, state) {
        if (state is HistoryLoading) {
          loading.show();
        } else {
          loading.dismiss();
        }
        if (state is HistoryInitial) {
          context.read<HistoryBloc>().add(HistoryBackup());
        }
      },
      builder: (context, state) {
        return BackgroundWhiteBlack(
            child: Padding(
          padding:
              EdgeInsets.only(top: Screen.width * 0.2, left: 12, right: 12),
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
                    borderRadius: BorderRadius.circular(12),
                    color: AppColor.white),
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: state.inHistory
                                ? AppColor.primary
                                : AppColor.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          "Terapi",
                          style: state.inHistory
                              ? AppFontStyle.s12.semibold.white
                              : AppFontStyle.s12.semibold.primary,
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
                            color:
                                state.inLab ? AppColor.primary : AppColor.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          "Lab",
                          style: state.inLab
                              ? AppFontStyle.s12.semibold.white
                              : AppFontStyle.s12.semibold.primary,
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
              if (state is HistorySuccess) _buildInSuccess(state)
            ],
          ),
        ));
      },
    );
  }

  Widget _buildInSuccess(HistoryState state) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.historyModel!.length,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          final item = state.historyModel![index];
          return Container(
            height: 100,
            margin: EdgeInsets.only(bottom: 10),
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
                        "${item.product} ${item.variant}",
                        style: AppFontStyle.s12.semibold.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.companyName,
                                style: AppFontStyle.s12.regular.primary,
                              ),
                              Text(
                                item.date,
                                style: AppFontStyle.s10.semibold.black,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "infus ke ${item.infus}",
                                style: AppFontStyle.s12.regular.black,
                              ),
                              Text(
                                item.nakes,
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
          );
        },
      ),
    );
  }
}
