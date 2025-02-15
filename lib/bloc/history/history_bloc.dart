import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raho_mobile/data/models/detail_history.dart';
import 'package:raho_mobile/data/models/history.dart';
import 'package:raho_mobile/data/repositories/history_repository.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository repository;
  List<HistoryModel>? _cachedHistory;

  HistoryBloc({required this.repository})
      : super(HistoryInitial(historyModel: <HistoryModel>[])) {
    on<FetchHistory>(_onFetchHistory);
    on<FetchDetailHistory>(_onFetchDetailHistory);
    on<HistoryBackup>(_onHistoryNull);
  }

  Future<void> _onFetchHistory(
      FetchHistory event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    try {
      final history = await repository.fetchHistory();
      _cachedHistory = history;
      emit(HistorySuccess(historyModel: history));
    } catch (e) {
      emit(HistoryError(
        message: "Failed to load data history: $e",
      ));
    }
  }

  Future<void> _onFetchDetailHistory(
      FetchDetailHistory event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    try {
      if (_cachedHistory == null) {
        await _onFetchHistory(FetchHistory(), emit);
      }
      final detailHistory =
          await repository.fetchDetailHistory(event.historyId);
      emit(HistoryDetailSuccess(
          historyModel: _cachedHistory, detailHistoryModel: detailHistory));
    } catch (e) {
      emit(HistoryError(
        message: "Failed to load data detail history: $e",
      ));
    }
  }

  Future<void> _onHistoryNull(
      HistoryBackup event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    try {
      if (_cachedHistory == null) {
        await _onFetchHistory(FetchHistory(), emit);
      }
      emit(HistoryInitial(historyModel: _cachedHistory));
    } catch (e) {
      emit(HistoryError(
        message: "Failed to load data profile: $e",
      ));
    }
  }
}
