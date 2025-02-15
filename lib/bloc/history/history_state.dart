part of 'history_bloc.dart';

class HistoryState extends Equatable {
  final bool inHistory;
  final bool inLab;
  final List<HistoryModel>? historyModel;

  const HistoryState(
      {this.inHistory = true, this.inLab = false, this.historyModel});

  HistoryState copyWith({
    bool? inHistory,
    bool? inLab,
    final List<HistoryModel>? historyModel,
  }) {
    return HistoryState(
        inHistory: inHistory ?? this.inHistory,
        inLab: inLab ?? this.inLab,
        historyModel: historyModel ?? this.historyModel);
  }

  @override
  List<Object?> get props => [inHistory, inLab, historyModel];
}

final class HistoryInitial extends HistoryState {
  const HistoryInitial({super.inHistory, super.inLab, super.historyModel});

  @override
  List<Object?> get props => [inHistory, inLab, historyModel];
}

final class HistoryLoading extends HistoryState {
  @override
  List<Object?> get props => [];
}

final class HistorySuccess extends HistoryState {
  const HistorySuccess({super.inHistory, super.inLab, super.historyModel});

  @override
  List<Object?> get props => [inHistory, inLab, historyModel];
}

final class HistoryDetailSuccess extends HistoryState {
  final DetailHistoryModel detailHistoryModel;

  const HistoryDetailSuccess(
      {super.inHistory,
      super.inLab,
      super.historyModel,
      required this.detailHistoryModel});

  @override
  List<Object?> get props =>
      [inHistory, inLab, historyModel, detailHistoryModel];
}

final class HistoryError extends HistoryState {
  final String message;

  const HistoryError({required this.message, super.inHistory, super.inLab});

  @override
  List<Object?> get props => [message, inHistory, inLab];
}
