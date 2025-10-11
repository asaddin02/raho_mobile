import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_member_apps/core/constants/app_assets.dart';
import 'package:raho_member_apps/core/constants/app_routes.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/storage/language_storage_service.dart';
import 'package:raho_member_apps/core/utils/extensions.dart';
import 'package:raho_member_apps/presentation/appstart/states/cubit/app_start/app_start_cubit.dart';
import 'package:raho_member_apps/presentation/appstart/ui/language_screen.dart';

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
  bool _languageSelectionShown = false;
  bool _canProceedToNext = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeSplash();
    });
  }

  Future<void> _initializeSplash() async {
    if (!mounted) return;
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    final shouldShowLanguageSelection =
        await LanguageService.isFirstTimeLanguageSelection();

    if (!mounted) return;
    if (shouldShowLanguageSelection) {
      if (mounted) {
        setState(() {
          _languageSelectionShown = true;
        });
      }
      if (mounted) {
        await LanguageSelectionDialog.showAndWait(context);
      }
      if (mounted) {
        setState(() {
          _canProceedToNext = true;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _canProceedToNext = true;
        });
      }
    }
    await Future.delayed(splashDelay);

    if (mounted && _canProceedToNext) {
      context.read<AppStartCubit>().checkAppStart();
    }
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
              theme.highlightColor.withValues(alpha: 0.3),
              theme.highlightColor.withValues(alpha: 0.3),
              theme.scaffoldBackgroundColor,
            ],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
        child: BlocListener<AppStartCubit, AppStartState>(
          listener: (context, state) {
            if (!_canProceedToNext) return;
            if (state is AppStartOnboarding) {
              context.goNamed(AppRoutes.onboarding.name);
            } else if (state is AppStartVerification) {
              context.goNamed(AppRoutes.verification.name);
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
