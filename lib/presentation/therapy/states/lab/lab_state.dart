part of 'lab_bloc.dart';

abstract class LabState extends Equatable {
  const LabState();

  @override
  List<Object?> get props => [];
}

class LabInitial extends LabState {}

class LabLoading extends LabState {}

class LabListLoaded extends LabState {
  final List<LabData> labs;
  final PaginationModelLab pagination;
  final LabFilterModel filters;
  final String? searchQuery;
  final String? selectedCompany;
  final String? dateFrom;
  final String? dateTo;
  final bool isLoadingMore;

  const LabListLoaded({
    required this.labs,
    required this.pagination,
    required this.filters,
    this.searchQuery,
    this.selectedCompany,
    this.dateFrom,
    this.dateTo,
    this.isLoadingMore = false,
  });

  LabListLoaded copyWith({
    List<LabData>? labs,
    PaginationModelLab? pagination,
    LabFilterModel? filters,
    String? searchQuery,
    String? selectedCompany,
    String? dateFrom,
    String? dateTo,
    bool? isLoadingMore,
  }) {
    return LabListLoaded(
      labs: labs ?? this.labs,
      pagination: pagination ?? this.pagination,
      filters: filters ?? this.filters,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCompany: selectedCompany ?? this.selectedCompany,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
    labs,
    pagination,
    filters,
    searchQuery,
    selectedCompany,
    dateFrom,
    dateTo,
    isLoadingMore,
  ];
}

class LabRefreshing extends LabState {
  final List<LabData> labs;

  const LabRefreshing({required this.labs});

  @override
  List<Object?> get props => [labs];
}

class LabError extends LabState {
  final String message;
  final List<LabData>? labs;

  const LabError({required this.message, this.labs});

  @override
  List<Object?> get props => [message, labs];
}

class LabDetailLoading extends LabState {
  final List<LabData>? labs;

  const LabDetailLoading({this.labs});

  @override
  List<Object?> get props => [labs];
}

class LabDetailLoaded extends LabState {
  final LabData labDetail;
  final List<LabData>? labs;

  const LabDetailLoaded({required this.labDetail, this.labs});

  @override
  List<Object?> get props => [labDetail, labs];
}

class LabDetailError extends LabState {
  final String message;
  final List<LabData>? labs;

  const LabDetailError({required this.message, this.labs});

  @override
  List<Object?> get props => [message, labs];
}
