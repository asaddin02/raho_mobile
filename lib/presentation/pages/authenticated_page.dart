import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_mobile/bloc/auth/auth_bloc.dart';
import 'package:raho_mobile/core/constants/route_constant.dart';

class AuthenticatedPage extends StatelessWidget {
  final Widget child;

  const AuthenticatedPage({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is! AuthAuthenticated) {
          context.go(RouteApp.login);
        }
      },
      child: child,
    );
  }
}