part of 'therapy_bloc.dart';

abstract class TherapyEvent extends Equatable {
  const TherapyEvent();

  @override
  List<Object?> get props => [];
}

class FetchTherapyList extends TherapyEvent {
  final int page;
  final String? search;
  final String? companyName;
  final String? productName;
  final String? dateFrom;
  final String? dateTo;

  const FetchTherapyList({
    this.page = 1,
    this.search,
    this.companyName,
    this.productName,
    this.dateFrom,
    this.dateTo,
  });

  @override
  List<Object?> get props => [
    page,
    search,
    companyName,
    productName,
    dateFrom,
    dateTo,
  ];
}

class LoadMoreTherapy extends TherapyEvent {
  const LoadMoreTherapy();
}

class RefreshTherapyList extends TherapyEvent {
  const RefreshTherapyList();
}

class SearchTherapy extends TherapyEvent {
  final String query;

  const SearchTherapy(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterTherapy extends TherapyEvent {
  final String? companyName;
  final String? productName;
  final String? dateFrom;
  final String? dateTo;

  const FilterTherapy({
    this.companyName,
    this.productName,
    this.dateFrom,
    this.dateTo,
  });

  @override
  List<Object?> get props => [companyName, productName, dateFrom, dateTo];
}

class ClearTherapyFilters extends TherapyEvent {
  const ClearTherapyFilters();
}

class FetchTherapyDetail extends TherapyEvent {
  final int id;

  const FetchTherapyDetail(this.id);

  @override
  List<Object?> get props => [id];
}
