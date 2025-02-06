import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raho_mobile/bloc/auth/auth_bloc.dart';
import 'package:raho_mobile/data/providers/auth_provider.dart';
import 'package:raho_mobile/data/repositories/auth_repository.dart';
import 'package:raho_mobile/data/services/storage_service.dart';
import 'package:raho_mobile/data/services/welcome_to_app.dart';
import 'package:raho_mobile/route/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  final prefs = await SharedPreferences.getInstance();
  final storageService = StorageService(prefs);
  final appKey = WelcomeService(prefs);

  final authProvider = AuthProvider(storageService);
  final authRepository = AuthRepository(authProvider, storageService);
  runApp(RahoMobile(
    authRepository: authRepository,
    storageService: storageService,
    welcomeService: appKey,
  ));
}

class RahoMobile extends StatelessWidget {
  final AuthRepository authRepository;
  final StorageService storageService;
  final WelcomeService welcomeService;

  const RahoMobile(
      {super.key,
      required this.authRepository,
      required this.storageService,
      required this.welcomeService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthBloc(authRepository, storageService),
        child: Builder(builder: (context) {
          final authBloc = context.read<AuthBloc>();
          final appRouter = AppRouter(authBloc, welcomeService);
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter.router,
            title: 'RAHO Mobile',
          );
        }));
  }
}
