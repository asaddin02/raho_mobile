part of 'lab_bloc.dart';

abstract class LabEvent extends Equatable {
  const LabEvent();

  @override
  List<Object?> get props => [];
}

class FetchLabList extends LabEvent {
  final int page;
  final String? search;
  final String? companyName;
  final String? dateFrom;
  final String? dateTo;

  const FetchLabList({
    this.page = 1,
    this.search,
    this.companyName,
    this.dateFrom,
    this.dateTo,
  });

  @override
  List<Object?> get props => [page, search, companyName, dateFrom, dateTo];
}

class LoadMoreLab extends LabEvent {
  const LoadMoreLab();
}

class RefreshLabList extends LabEvent {
  const RefreshLabList();
}

class SearchLab extends LabEvent {
  final String query;

  const SearchLab(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterLab extends LabEvent {
  final String? companyName;
  final String? dateFrom;
  final String? dateTo;

  const FilterLab({this.companyName, this.dateFrom, this.dateTo});

  @override
  List<Object?> get props => [companyName, dateFrom, dateTo];
}

class ClearLabFilters extends LabEvent {
  const ClearLabFilters();
}

class FetchLabDetail extends LabEvent {
  final int id;

  const FetchLabDetail(this.id);

  @override
  List<Object?> get props => [id];
}

class ClearLabDetail extends LabEvent {
  const ClearLabDetail();
}
