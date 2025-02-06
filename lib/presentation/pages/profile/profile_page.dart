import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_mobile/core/constants/route_constant.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/styles/app_text_style.dart';
import 'package:raho_mobile/core/utils/helper.dart';
import 'package:raho_mobile/presentation/template/background_white_black.dart';
import 'package:raho_mobile/presentation/widgets/profile_detail_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWhiteBlack(
        child: Padding(
      padding: EdgeInsets.only(top: 48, left: 12, right: 12),
      child: Column(
        children: [
          Text(
            "Profil Saya",
            textAlign: TextAlign.center,
            style: AppFontStyle.s20.semibold.white,
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
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
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/images/person.jpg"),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Mirza Ananta",
                        style: AppFontStyle.s16.bold.black,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "240224014056",
                        style: AppFontStyle.s12.regular.grey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Personal",
                          style: AppFontStyle.s16.bold.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ProfileDetailButton(
                          nameButton: "Data Pribadi",
                          iconData: CupertinoIcons.profile_circled,
                          onClick: () {
                            context.push(RouteApp.personalData);
                          }),
                      ProfileDetailButton(
                          nameButton: "Diagnosa Saya",
                          iconData: Icons.fact_check,
                          onClick: () {
                            context.push(RouteApp.myDiagnosis);
                          }),
                      ProfileDetailButton(
                          nameButton: "Referensi Code",
                          iconData: Icons.description,
                          onClick: () {
                            context.push(RouteApp.referenceCode);
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Personal",
                          style: AppFontStyle.s16.bold.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ProfileDetailButton(
                          nameButton: "Lokasi Cabang RAHO",
                          iconData: CupertinoIcons.location_solid,
                          onClick: () {
                            context.push(RouteApp.rahoBranchLocation);
                          }),
                      ProfileDetailButton(
                          nameButton: "Frequently Asked Question",
                          iconData: Icons.question_answer_outlined,
                          onClick: () {}),
                      ProfileDetailButton(
                          nameButton: "Bantuan",
                          iconData: Icons.help_outline_rounded,
                          onClick: () {}),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColor.black)),
                          child: Text(
                            "Keluar",
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
}
