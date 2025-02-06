import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_mobile/bloc/auth/auth_bloc.dart';
import 'package:raho_mobile/core/constants/route_constant.dart';
import 'package:raho_mobile/data/services/welcome_to_app.dart';
import 'package:raho_mobile/presentation/pages/authenticated_page.dart';
import 'package:raho_mobile/presentation/pages/dashboard/dashboard_page.dart';
import 'package:raho_mobile/presentation/pages/dashboard/myvoucher_page.dart';
import 'package:raho_mobile/presentation/pages/history/history_page.dart';
import 'package:raho_mobile/presentation/pages/login_page.dart';
import 'package:raho_mobile/presentation/pages/menu_navigation/bottom_navigation.dart';
import 'package:raho_mobile/presentation/pages/profile/diagnosis_me_page.dart';
import 'package:raho_mobile/presentation/pages/profile/personal_data_page.dart';
import 'package:raho_mobile/presentation/pages/profile/profile_page.dart';
import 'package:raho_mobile/presentation/pages/profile/raho_branch_location_page.dart';
import 'package:raho_mobile/presentation/pages/profile/reference_code_page.dart';
import 'package:raho_mobile/presentation/pages/splash_page.dart';
import 'package:raho_mobile/presentation/pages/transaction/detail_transaction.dart';
import 'package:raho_mobile/presentation/pages/transaction/transaction_page.dart';
import 'package:raho_mobile/presentation/pages/welcome_page.dart';

class AppRouter {
  final AuthBloc authBloc;
  final WelcomeService welcomeService;

  AppRouter(this.authBloc, this.welcomeService);

  late final router = GoRouter(
      initialLocation: RouteApp.splash,
      refreshListenable: GoRouterRefreshStream(authBloc.stream),
      routes: [
        GoRoute(
            path: RouteApp.splash,
            name: RouteName.splash,
            builder: (context, state) => SplashPage(
                  service: welcomeService,
                )),
        GoRoute(
            path: RouteApp.welcome,
            name: RouteName.welcome,
            builder: (context, state) => WelcomePage(
                  service: welcomeService,
                )),
        GoRoute(
            path: RouteApp.login,
            name: RouteName.login,
            builder: (context, state) {
              return LoginPage();
            }),
        ShellRoute(
            builder: (context, state, child) {
              return AuthenticatedPage(child: BottomNavigation(child: child));
            },
            routes: [
              GoRoute(
                  path: RouteApp.dashboard,
                  name: RouteName.dashboard,
                  builder: (context, state) => const DashboardPage(),
                  routes: [
                    GoRoute(
                        path: RouteName.myVoucher,
                        name: RouteName.myVoucher,
                        builder: (context, state) => const MyVoucherPage()),
                  ]),
              GoRoute(
                  path: RouteApp.transaction,
                  name: RouteName.transaction,
                  builder: (context, state) => const TransactionPage(),
                  routes: [
                    GoRoute(
                        path: RouteName.detailTransaction,
                        name: RouteName.detailTransaction,
                        builder: (context, state) => const DetailTransaction()),
                  ]),
              GoRoute(
                  path: RouteApp.history,
                  name: RouteName.history,
                  builder: (context, state) => const HistoryPage()),
              GoRoute(
                  path: RouteApp.profile,
                  name: RouteName.profile,
                  builder: (context, state) => const ProfilePage(),
                  routes: [
                    GoRoute(
                        path: RouteName.personalData,
                        name: RouteName.personalData,
                        builder: (context, state) => PersonalDataPage()),
                    GoRoute(
                        path: RouteName.referenceCode,
                        name: RouteName.referenceCode,
                        builder: (context, state) => ReferenceCodePage()),
                    GoRoute(
                        path: RouteName.myDiagnosis,
                        name: RouteName.myDiagnosis,
                        builder: (context, state) => DiagnosisMePage()),
                    GoRoute(
                        path: RouteName.rahoBranchLocation,
                        name: RouteName.rahoBranchLocation,
                        builder: (context, state) => RahoBranchLocationPage())
                  ]),
            ]),
      ]);
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notificationSubscription = stream.listen(
      (_) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> notificationSubscription;

  @override
  void dispose() {
    notificationSubscription.cancel();
    super.dispose();
  }
}
