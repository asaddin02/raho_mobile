import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raho_mobile/data/models/diagnosis.dart';
import 'package:raho_mobile/data/models/profile.dart';
import 'package:raho_mobile/data/repositories/user_repository.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  ProfileModel? _cachedProfile;

  UserBloc({required this.userRepository}) : super(const UserState()) {
    on<FetchProfile>(_onFetchProfile);
    on<FetchDiagnosis>(_onFetchDiagnosis);
    on<ToggleEdit>(_onToggleEdit);
    on<EditPersonalData>(_onEditPersonalData);
  }

  Future<void> _onFetchProfile(
    FetchProfile event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final profile = await userRepository.fetchProfile();
      _cachedProfile = profile;
      emit(UserLoadedProfile(profile: profile));
    } catch (e) {
      emit(UserError(
        message: "Failed to load data profile: $e",
      ));
    }
  }

  Future<void> _onFetchDiagnosis(
    FetchDiagnosis event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading(profile: _cachedProfile));
    try {
      final diagnosis = await userRepository.fetchDiagnosis();
      if (_cachedProfile == null) {
        _onFetchProfile(FetchProfile(), emit);
        emit(UserInitial(profile: _cachedProfile, diagnosis: diagnosis));
      }
      emit(UserLoadedDiagnosis(
        profile: _cachedProfile,
        diagnosis: diagnosis,
      ));
    } catch (e) {
      emit(UserError(
        message: "Failed to load diagnosis: $e",
      ));
    }
  }

  Future<void> _onToggleEdit(ToggleEdit event, Emitter<UserState> emit) async {
    if (_cachedProfile == null) {
      await _onFetchProfile(FetchProfile(), emit);
    }
    emit(state.copyWith(isEdit: !state.isEdit, profile: _cachedProfile));
  }

  Future<void> _onEditPersonalData(
      EditPersonalData event, Emitter<UserState> emit) async {
    emit(UserLoading(profile: _cachedProfile));
    try {
      final editProfile = await userRepository.editProfile(
        event.nik,
        event.address,
        event.city,
        event.dob,
        event.gender,
        event.noHpWa,
      );
      if (editProfile == "Success") {
        final newProfile = await userRepository.fetchProfile();
        _cachedProfile = newProfile;
        emit(UserLoadedProfile(profile: newProfile, isEdit: false));
      }
    } catch (e) {
      emit(UserError(
        message: "Failed to load diagnosis: $e",
      ));
    }
  }
}
