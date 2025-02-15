import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_mobile/bloc/user/user_bloc.dart';
import 'package:raho_mobile/core/constants/route_constant.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/styles/app_text_style.dart';
import 'package:raho_mobile/core/utils/helper.dart';
import 'package:raho_mobile/cubit/greeting/greeting_cubit.dart';
import 'package:raho_mobile/presentation/template/background_white_black.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GreetingCubit()),
        ],
        child: BackgroundWhiteBlack(
            child: Padding(
          padding: const EdgeInsets.only(top: 50, right: 16, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<GreetingCubit, GreetingState>(
                    builder: (context, state) {
                      return Text(
                        state.greeting,
                        style: AppFontStyle.s14.regular.white,
                      );
                    },
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColor.white,
                        )),
                    child: Icon(
                      Icons.notifications_outlined,
                      color: AppColor.white,
                    ),
                  )
                ],
              ),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  return Text(
                    state is UserLoadedProfile
                        ? state.profile!.name
                        : state is UserLoadedProfile || state.profile != null
                            ? state.profile!.name
                            : "",
                    style: AppFontStyle.s20.bold.white,
                  );
                },
              ),
              SizedBox(height: Screen.height * 0.05),
              GestureDetector(
                onTap: () => context.push(RouteApp.myVoucher),
                child: Container(
                  height: Screen.height * 0.12,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
                  decoration: BoxDecoration(
                      gradient: AppGradientColor.gradientPrimary,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: AppColor.black.withValues(alpha: 0.1),
                            blurRadius: 3,
                            spreadRadius: 2,
                            offset: Offset(0, 1))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: AppColor.black.withValues(alpha: 0.1),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(0, 1))
                          ],
                          color: AppColor.white,
                        ),
                        child: FaIcon(CupertinoIcons.tickets_fill),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Voucher Anda",
                            style: AppFontStyle.s12.semibold.white,
                          ),
                          Text(
                            "8",
                            style: AppFontStyle.s16.semibold.white,
                          ),
                        ],
                      ),
                      Container(
                        height: double.infinity,
                        width: 1,
                        color: AppColor.white,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Voucher Terpakai",
                            style: AppFontStyle.s12.semibold.white,
                          ),
                          Text(
                            "2",
                            style: AppFontStyle.s16.semibold.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Screen.height * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Terapi Terakhir",
                    style: AppFontStyle.s16.semibold.black,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColor.black,
                  )
                ],
              ),
              SizedBox(height: Screen.height * 0.02),
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
              ),
              const SizedBox(
                height: 12,
              ),
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
              ),
              SizedBox(height: Screen.height * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Event dan Promo",
                    style: AppFontStyle.s16.semibold.black,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColor.black,
                  )
                ],
              )
            ],
          ),
        )));
  }
}
