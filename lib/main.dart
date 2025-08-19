import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/authentication/states/auth/auth_bloc.dart';
import 'package:raho_member_apps/presentation/theme/app_theme.dart';
import 'package:raho_member_apps/presentation/theme/states/cubit/theme_cubit.dart';
import 'package:raho_member_apps/route/app_router.dart';
import 'presentation/profile/states/language/language_bloc.dart';
import 'presentation/widgets/snackbar_toast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  await setupLocator();
  runApp(const RahoMemberApps());
}

class RahoMemberApps extends StatelessWidget {
  const RahoMemberApps({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ThemeCubit>()),
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<LanguageBloc>()..add(LoadLanguage())),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, languageState) {
              final appRouter = AppRouter();

              Locale currentLocale = const Locale('en');
              if (languageState is LanguageChanged) {
                currentLocale = languageState.locale;
              }

              return MaterialApp.router(
                locale: currentLocale,
                supportedLocales: const [
                  Locale('id'),
                  Locale('en'),
                  Locale('zh'),
                ],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeState.themeMode,
                debugShowCheckedModeBanner: false,
                routerConfig: appRouter.router,
                title: 'Rahocare for Member',
                builder: (context, child) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: child,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
