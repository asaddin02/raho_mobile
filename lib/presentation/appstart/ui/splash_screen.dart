import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_member_apps/core/constants/app_assets.dart';
import 'package:raho_member_apps/core/constants/app_routes.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/utils/extensions.dart';
import 'package:raho_member_apps/presentation/appstart/states/cubit/app_start/app_start_cubit.dart';

class SplashScreenWrapper extends StatelessWidget {
  const SplashScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AppStartCubit>(),
      child: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const Duration splashDelay = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(splashDelay, () {
        if (mounted) {
          context.read<AppStartCubit>().checkAppStart();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withValues(alpha: 0.1),
              theme.colorScheme.primary.withValues(alpha: 0.05),
              theme.scaffoldBackgroundColor,
            ],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
        child: BlocListener<AppStartCubit, AppStartState>(
          listener: (context, state) {
            if (state is AppStartOnboarding) {
              context.goNamed(AppRoutes.onboarding.name);
            } else if (state is AppStartDashboard) {
              context.goNamed(AppRoutes.dashboard.name);
            } else if (state is AppStartLogin) {
              context.goNamed(AppRoutes.login.name);
            }
          },
          child: Center(
            child: Transform.scale(
              scale: 0.4,
              child: Image.asset(AppAssets.logoApp),
            ),
          ),
        ),
      ),
    );
  }
}
