import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:raho_member_apps/core/network/app_config.dart';
import 'package:raho_member_apps/core/storage/app_storage_service.dart';
import 'package:raho_member_apps/core/storage/secure_storage_service.dart';
import 'package:raho_member_apps/data/providers/company_provider.dart';
import 'package:raho_member_apps/data/providers/dashboard_provider.dart';
import 'package:raho_member_apps/data/providers/event_provider.dart';
import 'package:raho_member_apps/data/providers/lab_provider.dart';
import 'package:raho_member_apps/data/providers/otp_provider.dart';
import 'package:raho_member_apps/data/providers/therapy_provider.dart';
import 'package:raho_member_apps/data/providers/transaction_provider.dart';
import 'package:raho_member_apps/data/repositories/company_repository.dart';
import 'package:raho_member_apps/data/repositories/dashboard_repository.dart';
import 'package:raho_member_apps/data/repositories/event_repository.dart';
import 'package:raho_member_apps/data/repositories/lab_repository.dart';
import 'package:raho_member_apps/data/repositories/otp_repository.dart';
import 'package:raho_member_apps/data/repositories/therapy_repository.dart';
import 'package:raho_member_apps/data/repositories/transaction_repository.dart';
import 'package:raho_member_apps/data/services/api_services.dart';
import 'package:raho_member_apps/data/services/firebase_service.dart';
import 'package:raho_member_apps/presentation/appstart/states/cubit/app_start/app_start_cubit.dart';
import 'package:raho_member_apps/presentation/authentication/states/auth/auth_bloc.dart';
import 'package:raho_member_apps/presentation/authentication/states/password/create_password_bloc.dart';
import 'package:raho_member_apps/presentation/authentication/states/password_visibility/password_visibility_cubit.dart';
import 'package:raho_member_apps/presentation/authentication/states/verification_number/verify_number_bloc.dart';
import 'package:raho_member_apps/presentation/dashboard/states/dashboard/dashboard_bloc.dart';
import 'package:raho_member_apps/presentation/dashboard/states/event/event_bloc.dart';
import 'package:raho_member_apps/presentation/dashboard/states/notification/notification_bloc.dart';
import 'package:raho_member_apps/presentation/profile/states/company/company_bloc.dart';
import 'package:raho_member_apps/presentation/profile/states/language/language_bloc.dart';
import 'package:raho_member_apps/presentation/profile/states/profile/profile_bloc.dart';
import 'package:raho_member_apps/presentation/profile/states/references/references_cubit.dart';
import 'package:raho_member_apps/presentation/theme/states/cubit/theme_cubit.dart';
import 'package:raho_member_apps/presentation/therapy/states/lab/lab_bloc.dart';
import 'package:raho_member_apps/presentation/therapy/states/therapy/therapy_bloc.dart';
import 'package:raho_member_apps/presentation/transaction/states/transaction/transaction_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:raho_member_apps/data/providers/auth_provider.dart';
import 'package:raho_member_apps/data/providers/user_provider.dart';
import 'package:raho_member_apps/data/repositories/auth_repository.dart';
import 'package:raho_member_apps/data/repositories/user_repository.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  final prefs = await SharedPreferences.getInstance();

  // Core Dependencies - Create immediately
  sl.registerSingleton<SharedPreferences>(prefs);
  sl.registerSingleton<Dio>(Dio());

  // Service App - Lazy load
  sl.registerLazySingleton<IApiService>(
    () => ApiService(baseUrl: AppConfig.baseUrl),
  );
  sl.registerLazySingleton<FirebaseService>(() => FirebaseService());

  // Service Data - Lazy load
  sl.registerLazySingleton<AppStorageService>(
    () => AppStorageService(sl<SharedPreferences>()),
  );
  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService());

  // Provider - Lazy load
  sl.registerLazySingleton<OtpProvider>(() => OtpProvider());
  sl.registerLazySingleton<AuthProvider>(() => AuthProvider());
  sl.registerLazySingleton<UserProvider>(() => UserProvider());
  sl.registerLazySingleton<DashboardProvider>(() => DashboardProvider());
  sl.registerLazySingleton<CompanyProvider>(() => CompanyProvider());
  sl.registerLazySingleton<TherapyProvider>(() => TherapyProvider());
  sl.registerLazySingleton<LabProvider>(() => LabProvider());
  sl.registerLazySingleton<TransactionProvider>(() => TransactionProvider());
  sl.registerLazySingleton<EventProvider>(() => EventProvider());

  // Repository - Lazy load
  sl.registerLazySingleton<OtpRepository>(
    () => OtpRepository(provider: sl<OtpProvider>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      authProvider: sl<AuthProvider>(),
      storageService: sl<SecureStorageService>(),
    ),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepository(provider: sl<UserProvider>()),
  );
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepository(provider: sl<DashboardProvider>()),
  );
  sl.registerLazySingleton<CompanyRepository>(
    () => CompanyRepository(provider: sl<CompanyProvider>()),
  );
  sl.registerLazySingleton<TherapyRepository>(
    () => TherapyRepository(provider: sl<TherapyProvider>()),
  );
  sl.registerLazySingleton<LabRepository>(
    () => LabRepository(provider: sl<LabProvider>()),
  );
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepository(provider: sl<TransactionProvider>()),
  );
  sl.registerLazySingleton<EventRepository>(
    () => EventRepository(provider: sl<EventProvider>()),
  );

  // Global State Management - SINGLETON
  sl.registerLazySingleton<ThemeCubit>(
    () => ThemeCubit(services: sl<AppStorageService>()),
  );
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(sl<AuthRepository>()));
  sl.registerLazySingleton<LanguageBloc>(
    () => LanguageBloc(sl<SharedPreferences>()),
  );

  // Per-Screen/Temporary Blocs - FACTORY
  sl.registerFactory<AppStartCubit>(
    () => AppStartCubit(sl<AppStorageService>(), sl<SecureStorageService>()),
  );
  sl.registerFactory<VerifyNumberBloc>(
    () => VerifyNumberBloc(
      sl<AppStorageService>(),
      repository: sl<OtpRepository>(),
    ),
  );
  sl.registerFactory<PasswordVisibilityCubit>(() => PasswordVisibilityCubit());
  sl.registerFactory<CreatePasswordBloc>(
    () => CreatePasswordBloc(authRepository: sl<AuthRepository>()),
  );
  sl.registerFactory<DashboardBloc>(
    () => DashboardBloc(repository: sl<DashboardRepository>()),
  );
  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(repository: sl<UserRepository>()),
  );
  sl.registerFactory<CompanyBloc>(
    () => CompanyBloc(repository: sl<CompanyRepository>()),
  );
  sl.registerFactory<ReferenceCubit>(
    () => ReferenceCubit(repository: sl<UserRepository>()),
  );
  sl.registerFactory<TherapyBloc>(
    () => TherapyBloc(repository: sl<TherapyRepository>()),
  );
  sl.registerFactory<LabBloc>(() => LabBloc(repository: sl<LabRepository>()));
  sl.registerFactory<TransactionBloc>(
    () => TransactionBloc(repository: sl<TransactionRepository>()),
  );
  sl.registerFactory<EventBloc>(
    () => EventBloc(repository: sl<EventRepository>()),
  );
  sl.registerFactory<NotificationBloc>(
    () => NotificationBloc(
      repository: sl<EventRepository>(),
      firebaseService: sl<FirebaseService>(),
    ),
  );
}
