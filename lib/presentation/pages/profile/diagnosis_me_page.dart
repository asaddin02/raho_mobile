import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_mobile/bloc/user/user_bloc.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/styles/app_text_style.dart';
import 'package:raho_mobile/core/utils/helper.dart';
import 'package:raho_mobile/core/utils/loading.dart';
import 'package:raho_mobile/data/models/diagnosis.dart';
import 'package:raho_mobile/presentation/template/background_white_black.dart';

class DiagnosisMePage extends StatefulWidget {
  const DiagnosisMePage({super.key});

  @override
  State<DiagnosisMePage> createState() => _DiagnosisMePageState();
}

class _DiagnosisMePageState extends State<DiagnosisMePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserBloc>().add(FetchDiagnosis());
    });
  }

  @override
  Widget build(BuildContext context) {
    final Loading loading = Loading(context: context);

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
                        "Diagnosa Saya",
                        textAlign: TextAlign.center,
                        style: AppFontStyle.s20.semibold.white,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is UserLoading) {
                      loading.show();
                    } else {
                      loading.dismiss();
                    }
                  },
                  builder: (context, state) {
                    return ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Container(
                            padding: EdgeInsets.all(16),
                            width: Screen.width,
                            margin: EdgeInsets.only(
                                bottom: 12, left: 4, right: 4),
                            decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.black.withValues(
                                        alpha: 0.3),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                  )
                                ]),
                            child: state is UserError
                                ? _buildErrorWidget()
                                : state is UserLoadedDiagnosis || state.diagnosis != null
                                ? _buildDiagnosisContent(state.diagnosis!)
                                : Container()
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildDiagnosisContent(DiagnosisModel diagnosis) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  diagnosis.name,
                  style: AppFontStyle.s14.semibold.black,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColor.primary,
                      size: 14,
                    ),
                    Text(
                      diagnosis.partnerName,
                      style: AppFontStyle.s12.regular.black,
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  diagnosis.noId,
                  style: AppFontStyle.s12.regular.grey,
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "Catatan Tambahan",
          style: AppFontStyle.s14.semibold.black,
        ),
        const SizedBox(height: 5),
        Text(
          formatBulletPoints(diagnosis.note),
          style: AppFontStyle.s12.regular.black,
        ),
        const SizedBox(height: 10),
        Text(
          "Keluhan dan Riwayat Penyakit",
          style: AppFontStyle.s14.semibold.black,
        ),
        const SizedBox(height: 5),
        Text(
          formatBulletPoints(diagnosis.currentIllness),
          style: AppFontStyle.s12.regular.black,
        ),
        const SizedBox(height: 10),
        Text(
          "Riwayat Penyakit Terdahulu dan Keluarga",
          style: AppFontStyle.s14.semibold.black,
        ),
        const SizedBox(height: 5),
        Text(
          formatBulletPoints(diagnosis.previousIllness),
          style: AppFontStyle.s12.regular.black,
        ),
        const SizedBox(height: 10),
        Text(
          "Riwayat Sosial dan Kebiasaan",
          style: AppFontStyle.s14.semibold.black,
        ),
        const SizedBox(height: 5),
        Text(
          formatBulletPoints(diagnosis.socialHabit),
          style: AppFontStyle.s12.regular.black,
        ),
        const SizedBox(height: 10),
        Text(
          "Riwayat Pengobatan",
          style: AppFontStyle.s14.semibold.black,
        ),
        const SizedBox(height: 5),
        Text(
          formatBulletPoints(diagnosis.treatmentHistory),
          style: AppFontStyle.s12.regular.black,
        ),
        const SizedBox(height: 10),
        Text(
          "Pemeriksaan Fisik",
          style: AppFontStyle.s14.semibold.black,
        ),
        const SizedBox(height: 5),
        Text(
          formatBulletPoints(diagnosis.physicalExamination),
          style: AppFontStyle.s12.regular.black,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: GestureDetector(
        onTap: () => context.read<UserBloc>().add(FetchDiagnosis()),
        child: Column(
          children: [
            Icon(
              Icons.refresh,
              color: AppColor.primary,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Try load again",
              style: AppFontStyle.s16.semibold.primary,
            ),
          ],
        ),
      ),
    );
  }
}
