import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_mobile/bloc/auth/auth_bloc.dart';
import 'package:raho_mobile/core/constants/route_constant.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/utils/splash_animation.dart';
import 'package:raho_mobile/data/services/welcome_to_app.dart';

class SplashPage extends StatelessWidget {
  final WelcomeService service;

  const SplashPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(CheckAuth());
    });

    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Transform.scale(
              scale: 0.4,
              child: AnimatedSplashScreen(
                imagePath: 'assets/images/logo_raho.png',
                onFinish: (GoRouterState state) async {
                  final authState = context.read<AuthBloc>().state;
                  final key = await service.getKey();

                  if ((key == 0 || key == null) && context.mounted) {
                    context.go(RouteApp.welcome);
                    return;
                  }
                  if (authState is AuthAuthenticated && context.mounted) {
                    context.go(RouteApp.dashboard);
                    return;
                  }

                  if (context.mounted) context.go(RouteApp.login);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
