import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/firebase_options.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/authentication/states/auth/auth_bloc.dart';
import 'package:raho_member_apps/presentation/dashboard/states/notification/notification_bloc.dart';
import 'package:raho_member_apps/presentation/theme/app_theme.dart';
import 'package:raho_member_apps/presentation/theme/states/cubit/theme_cubit.dart';
import 'package:raho_member_apps/route/app_router.dart';
import 'presentation/profile/states/language/language_bloc.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint("Handling a background message: ${message.messageId}");
  debugPrint("Message data: ${message.data}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  await setupLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ThemeCubit>()),
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<NotificationBloc>()),
        BlocProvider(create: (_) => sl<LanguageBloc>()..add(LoadLanguage())),
      ],
      child: const RahoMemberApps(),
    ),
  );
}

class RahoMemberApps extends StatefulWidget {
  const RahoMemberApps({super.key});

  @override
  State<RahoMemberApps> createState() => _RahoMemberAppsState();
}

class _RahoMemberAppsState extends State<RahoMemberApps>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<NotificationBloc>().add(InitializeNotifications());
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!mounted) return;
    if (state == AppLifecycleState.resumed) {
      context.read<NotificationBloc>().add(RefreshFirebaseToken());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
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
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: child,
                );
              },
            );
          },
        );
      },
    );
  }
}
