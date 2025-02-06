import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_mobile/bloc/auth/auth_bloc.dart';
import 'package:raho_mobile/core/constants/app_constant.dart';
import 'package:raho_mobile/core/constants/route_constant.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/styles/app_text_style.dart';
import 'package:raho_mobile/core/utils/helper.dart';
import 'package:raho_mobile/presentation/widgets/captcha_painter.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController idRegister = TextEditingController();
  final TextEditingController captcha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(GenerateCaptcha());
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: AppColor.primary,
                ),
              ),
            );
          } else {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          }

          if (state is AuthSuccess) {
            context.read<AuthBloc>().add(CheckAuth());
            Fluttertoast.showToast(
              msg: 'Login berhasil',
              gravity: ToastGravity.CENTER,
            );
            Future.delayed(Duration.zero, () {
              if (context.mounted) {
                context.go(RouteApp.dashboard);
              }
            });
          }

          if (state is AuthError) {
            Fluttertoast.showToast(
              msg: state.message,
              gravity: ToastGravity.CENTER,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: AppColor.black2,
                      size: 30,
                    ),
                  ),
                ),
                Image.asset(
                  "assets/images/logo_raho_crop.png",
                  width: Screen.width * 0.6,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: AppFontStyle.s28.semibold.black,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      AppConstant.LOGIN_COMMAND,
                      style: AppFontStyle.s12.light.grey,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "ID Registrasi",
                      style: AppFontStyle.s11.regular.black,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: idRegister,
                      style: AppFontStyle.s14.regular.black,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: AppColor.black)),
                          errorBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: AppColor.black)) ,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: AppColor.black)),
                          hintText: "Nomor ID Registrasi",
                          hintStyle: AppFontStyle.s11.regular.grey4),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Captcha",
                      style: AppFontStyle.s12.regular.black,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: captcha,
                      style: AppFontStyle.s14.regular.black,
                      decoration: InputDecoration(
                          suffixIcon: SizedBox(
                            width: 160,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      height: 25,
                                      child: CustomPaint(
                                        painter: CaptchaPainter(state.captcha),
                                        child: const SizedBox.expand(),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<AuthBloc>()
                                        .add(GenerateCaptcha());
                                  },
                                  child: Icon(
                                    Icons.refresh_rounded,
                                    color: AppColor.primary,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                              ],
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Kode Captcha",
                          hintStyle: AppFontStyle.s11.regular.grey4),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Lupa kata sandi?",
                        style: AppFontStyle.s11.bold.black,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      if (idRegister.text.isNotEmpty ||
                          captcha.text.isNotEmpty) {
                        context.read<AuthBloc>().add(LoginSubmitted(
                            idRegistration: idRegister.text,
                            captcha: captcha.text));
                      } else {
                        Fluttertoast.showToast(
                            msg: 'ID Registrasi dan Captcha wajib diisi',
                            gravity: ToastGravity.CENTER);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      width: Screen.width,
                      decoration: BoxDecoration(
                          color: AppColor.black2,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Masuk",
                        style: AppFontStyle.s16.bold.white,
                      ),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
