part of 'therapy_bloc.dart';

abstract class TherapyState extends Equatable {
  const TherapyState();

  @override
  List<Object?> get props => [];
}

class TherapyInitial extends TherapyState {}

class TherapyLoading extends TherapyState {}

class TherapyListLoaded extends TherapyState {
  final List<TherapyData> therapies;
  final PaginationModel pagination;
  final FilterModel filters;
  final String? searchQuery;
  final String? selectedCompany;
  final String? selectedProduct;
  final String? dateFrom;
  final String? dateTo;
  final bool isLoadingMore;

  const TherapyListLoaded({
    required this.therapies,
    required this.pagination,
    required this.filters,
    this.searchQuery,
    this.selectedCompany,
    this.selectedProduct,
    this.dateFrom,
    this.dateTo,
    this.isLoadingMore = false,
  });

  TherapyListLoaded copyWith({
    List<TherapyData>? therapies,
    PaginationModel? pagination,
    FilterModel? filters,
    String? searchQuery,
    String? selectedCompany,
    String? selectedProduct,
    String? dateFrom,
    String? dateTo,
    bool? isLoadingMore,
  }) {
    return TherapyListLoaded(
      therapies: therapies ?? this.therapies,
      pagination: pagination ?? this.pagination,
      filters: filters ?? this.filters,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCompany: selectedCompany ?? this.selectedCompany,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
    therapies,
    pagination,
    filters,
    searchQuery,
    selectedCompany,
    selectedProduct,
    dateFrom,
    dateTo,
    isLoadingMore,
  ];
}

class TherapyRefreshing extends TherapyState {
  final List<TherapyData> therapies;

  const TherapyRefreshing({required this.therapies});

  @override
  List<Object?> get props => [therapies];
}

class TherapyError extends TherapyState {
  final String messageCode;
  final String? debugMessage;
  final List<TherapyData>? therapies;

  const TherapyError({
    required this.messageCode,
    this.debugMessage,
    this.therapies,
  });

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (messageCode) {
      case 'THERAPY_HISTORY_SUCCESS':
        return localizations.therapy_history_success;
      case 'THERAPY_HISTORY_FAILED':
        return localizations.therapy_history_failed;
      case 'PATIENT_NOT_FOUND':
        return localizations.patient_not_found;
      case 'ERROR_SYSTEM':
        return localizations.error_system;
      case 'ERROR_SERVER':
        return localizations.error_server;
      case 'UNKNOWN_ERROR':
        return localizations.unknown_error;
      default:
        return localizations.unknown_error;
    }
  }

  @override
  List<Object?> get props => [messageCode, debugMessage, therapies];
}

class TherapyDetailLoading extends TherapyState {
  final List<TherapyData>? therapies;

  const TherapyDetailLoading({this.therapies});

  @override
  List<Object?> get props => [therapies];
}

class TherapyDetailLoaded extends TherapyState {
  final DetailTherapyModel therapyDetail;
  final List<TherapyData>? therapies;

  const TherapyDetailLoaded({required this.therapyDetail, this.therapies});

  @override
  List<Object?> get props => [therapyDetail, therapies];
}

class TherapyDetailError extends TherapyState {
  final String messageCode;
  final String? debugMessage;
  final List<TherapyData>? therapies;

  const TherapyDetailError({
    required this.messageCode,
    this.debugMessage,
    this.therapies,
  });

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (messageCode) {
      case 'THERAPY_DETAIL_SUCCESS':
        return localizations.therapy_detail_success;
      case 'THERAPY_NOT_FOUND':
        return localizations.therapy_not_found;
      case 'THERAPY_DETAIL_FAILED':
        return localizations.therapy_detail_failed;
      case 'ERROR_SYSTEM':
        return localizations.error_system;
      case 'ERROR_SERVER':
        return localizations.error_server;
      case 'UNKNOWN_ERROR':
        return localizations.unknown_error;
      default:
        return localizations.unknown_error;
    }
  }

  @override
  List<Object?> get props => [messageCode, debugMessage, therapies];
}
