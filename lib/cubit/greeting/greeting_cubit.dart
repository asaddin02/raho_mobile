import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'greeting_state.dart';

class GreetingCubit extends Cubit<GreetingState> {
  late AppLifecycleListener _lifecycleListener;

  GreetingCubit() : super(GreetingState(greeting: "")) {
    _updateGreeting();

    // Setup lifecycle listener
    _lifecycleListener = AppLifecycleListener(
      onStateChange: (state) {
        if (state == AppLifecycleState.resumed) {
          _updateGreeting();
        }
      },
    );
  }

  void _updateGreeting() {
    final hour = DateTime.now().hour;
    String greeting;

    if (hour >= 3 && hour < 11) {
      greeting = "Selamat Pagi";
    } else if (hour >= 11 && hour < 15) {
      greeting = "Selamat Siang";
    } else if (hour >= 15 && hour < 18) {
      greeting = "Selamat Sore";
    } else {
      greeting = "Selamat Malam";
    }

    emit(GreetingState(greeting: greeting));
  }

  @override
  Future<void> close() {
    _lifecycleListener.dispose();
    return super.close();
  }
}
