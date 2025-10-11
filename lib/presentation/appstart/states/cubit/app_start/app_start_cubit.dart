import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raho_member_apps/core/storage/app_storage_service.dart';
import 'package:raho_member_apps/core/storage/secure_storage_service.dart';

part 'app_start_state.dart';

class AppStartCubit extends Cubit<AppStartState> {
  final AppStorageService storageService;
  final SecureStorageService secureStorageService;

  AppStartCubit(this.storageService, this.secureStorageService)
    : super(AppStartInitial());

  Future<void> checkAppStart() async {
    final onboardingStatus = storageService.onboardingStatus;
    final verifyStatus = storageService.verifyStatus;
    final hasToken = await secureStorageService.hasToken();

    if (onboardingStatus != 1) {
      return emit(AppStartOnboarding());
    }

    if (verifyStatus != 1) {
      return (emit(AppStartVerification()));
    }

    if (!hasToken) {
      return emit(AppStartLogin());
    }

    emit(AppStartDashboard());
  }
}
