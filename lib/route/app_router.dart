import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_member_apps/core/constants/app_routes.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/presentation/authentication/states/auth/auth_bloc.dart';
import 'package:raho_member_apps/presentation/authentication/ui/create_password.dart';
import 'package:raho_member_apps/presentation/authentication/ui/login_page.dart';
import 'package:raho_member_apps/presentation/authentication/ui/otp_page.dart';
import 'package:raho_member_apps/presentation/authentication/ui/verification_page.dart';
import 'package:raho_member_apps/presentation/dashboard/ui/dashboard_page.dart';
import 'package:raho_member_apps/presentation/dashboard/ui/event_detail_page.dart';
import 'package:raho_member_apps/presentation/dashboard/ui/event_list_page.dart';
import 'package:raho_member_apps/presentation/menu_navigation/ui/bottom_navigation.dart';
import 'package:raho_member_apps/presentation/onboarding/ui/onboarding_screen.dart';
import 'package:raho_member_apps/presentation/appstart/ui/splash_screen.dart';
import 'package:raho_member_apps/presentation/profile/ui/branch_location_page.dart';
import 'package:raho_member_apps/presentation/profile/ui/my_diagnosis_page.dart';
import 'package:raho_member_apps/presentation/profile/ui/personal_data_page.dart';
import 'package:raho_member_apps/presentation/profile/ui/profile_page.dart';
import 'package:raho_member_apps/presentation/profile/ui/reference_code_page.dart';
import 'package:raho_member_apps/presentation/therapy/ui/detail_lab_page.dart';
import 'package:raho_member_apps/presentation/therapy/ui/detail_therapy_page.dart';
import 'package:raho_member_apps/presentation/therapy/ui/history_page.dart';
import 'package:raho_member_apps/presentation/transaction/ui/detail_transaction.dart';
import 'package:raho_member_apps/presentation/transaction/ui/transaction_page.dart';

class AppRouter {
  late final router = GoRouter(
    initialLocation: AppRoutes.splash.path,
    refreshListenable: GoRouterRefreshStream(sl<AuthBloc>().stream),
    routes: [
      GoRoute(
        path: AppRoutes.splash.path,
        name: AppRoutes.splash.name,
        builder: (context, state) => const SplashScreenWrapper(),
      ),
      GoRoute(
        path: AppRoutes.onboarding.path,
        name: AppRoutes.onboarding.name,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.verification.path,
        name: AppRoutes.verification.name,
        builder: (context, state) => const VerificationPage(),
      ),
      GoRoute(
        path: AppRoutes.otp.path,
        name: AppRoutes.otp.name,
        builder: (context, state) {
          final registerId = state.pathParameters['id_register']!;
          final numberPhone = state.pathParameters['mobile']!;
          return OtpWrapper(idRegister: registerId, mobile: numberPhone);
        },
      ),
      GoRoute(
        path: AppRoutes.createPassword.path,
        name: AppRoutes.createPassword.name,
        builder: (context, state) =>
            CreatePasswordPage(patientId: state.pathParameters['patientId']!),
      ),
      GoRoute(
        path: AppRoutes.login.path,
        name: AppRoutes.login.name,
        builder: (context, state) =>
            const LoginWrapper(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return BottomNavigation(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.dashboard.path,
            name: AppRoutes.dashboard.name,
            builder: (context, state) => const DashboardWrapper(),
            routes: [
              GoRoute(
                path: AppRoutes.eventList.path,
                name: AppRoutes.eventList.name,
                builder: (context, state) {
                  return EventListWrapper();
                },
              ),
              GoRoute(
                path: AppRoutes.eventDetail.path,
                name: AppRoutes.eventDetail.name,
                builder: (context, state) {
                  final eventId =
                      int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
                  return EventDetailWrapper(eventId: eventId.toString());
                },
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.profile.path,
            name: AppRoutes.profile.name,
            builder: (context, state) => const ProfilePageWrapper(),
            routes: [
              GoRoute(
                path: AppRoutes.personalData.path,
                name: AppRoutes.personalData.name,
                builder: (context, state) => const PersonalDataPage(),
              ),
              GoRoute(
                path: AppRoutes.myDiagnosis.path,
                name: AppRoutes.myDiagnosis.name,
                builder: (context, state) => const MyDiagnosisWrapper(),
              ),
              GoRoute(
                path: AppRoutes.referenceCode.path,
                name: AppRoutes.referenceCode.name,
                builder: (context, state) => const ReferenceCodeWrapper(),
              ),
              GoRoute(
                path: AppRoutes.branchLocation.path,
                name: AppRoutes.branchLocation.name,
                builder: (context, state) => const BranchLocationPage(),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.therapy.path,
            name: AppRoutes.therapy.name,
            builder: (context, state) => const HistoryPageWrapper(),
            routes: [
              GoRoute(
                path: AppRoutes.detailTherapy.path,
                name: AppRoutes.detailTherapy.name,
                builder: (context, state) {
                  final therapyId =
                      int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
                  return DetailTherapyPageWrapper(therapyId: therapyId);
                },
              ),
              GoRoute(
                path: AppRoutes.detailLab.path,
                name: AppRoutes.detailLab.name,
                builder: (context, state) {
                  final labId =
                      int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
                  return DetailLabPageWrapper(labId: labId);
                },
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.transaction.path,
            name: AppRoutes.transaction.name,
            builder: (context, state) => const TransactionPageWrapper(),
            routes: [
              GoRoute(
                path: AppRoutes.detailTransaction.path,
                name: AppRoutes.detailTransaction.name,
                builder: (context, state) {
                  final transactionId =
                      int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
                  final transactionType =
                      state.pathParameters['type'] ?? 'payment';
                  return DetailTransactionWrapper(
                    transactionId: transactionId,
                    transactionType: transactionType,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notificationSubscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> notificationSubscription;

  @override
  void dispose() {
    notificationSubscription.cancel();
    super.dispose();
  }
}
