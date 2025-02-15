part of 'history_bloc.dart';

sealed class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object?> get props => [];
}

final class FetchHistory extends HistoryEvent {}

final class FetchDetailHistory extends HistoryEvent {
  final int historyId;

  const FetchDetailHistory({required this.historyId});
}

final class HistoryBackup extends HistoryEvent {}
