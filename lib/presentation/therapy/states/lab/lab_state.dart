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
  final String messageCode;
  final String? debugMessage;
  final List<LabData>? labs;

  const LabError({required this.messageCode, this.debugMessage, this.labs});

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (messageCode) {
      case 'LAB_DATA_FETCHED':
        return localizations.lab_data_fetched;
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
  List<Object?> get props => [messageCode, debugMessage, labs];
}

class LabDetailLoading extends LabState {
  final List<LabData>? labs;

  const LabDetailLoading({this.labs});

  @override
  List<Object?> get props => [labs];
}

class LabDetailLoaded extends LabState {
  final DetailLabModel labDetail;
  final List<LabData>? labs;

  const LabDetailLoaded({required this.labDetail, this.labs});

  @override
  List<Object?> get props => [labDetail, labs];
}

class LabDetailError extends LabState {
  final String messageCode;
  final String? debugMessage;
  final List<LabData>? labs;

  const LabDetailError({
    required this.messageCode,
    this.debugMessage,
    this.labs,
  });

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (messageCode) {
      case 'LAB_DETAIL_FETCHED':
        return localizations.lab_detail_fetched;
      case 'LAB_ID_REQUIRED':
        return localizations.lab_id_required;
      case 'LAB_RECORD_NOT_FOUND':
        return localizations.lab_record_not_found;
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
  List<Object?> get props => [messageCode, debugMessage, labs];
}
