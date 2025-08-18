part of 'company_bloc.dart';

abstract class CompanyState extends Equatable {
  const CompanyState();

  @override
  List<Object?> get props => [];
}

class CompanyInitial extends CompanyState {}

class CompanyLoading extends CompanyState {}

class CompanySuccess extends CompanyState {
  final List<Company> companies;
  final String messageCode;

  const CompanySuccess({
    required this.companies,
    required this.messageCode,
  });

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (messageCode) {
      case 'COMPANIES_FETCH_SUCCESS':
        return localizations.companies_fetch_success;
      default:
        return localizations.companies_fetch_success;
    }
  }

  @override
  List<Object?> get props => [companies, messageCode];
}

class CompanyEmpty extends CompanyState {
  final String messageCode;

  const CompanyEmpty({required this.messageCode});

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (messageCode) {
      case 'COMPANIES_EMPTY':
        return localizations.companies_empty;
      default:
        return localizations.companies_empty;
    }
  }

  @override
  List<Object?> get props => [messageCode];
}

class CompanyError extends CompanyState {
  final String messageCode;
  final String? debugMessage;

  const CompanyError({
    required this.messageCode,
    this.debugMessage,
  });

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (messageCode) {
      case 'ERROR_SERVER':
        return localizations.error_server;
      case 'UNKNOWN_ERROR':
        return localizations.unknown_error;
      default:
        return localizations.unknown_error;
    }
  }

  @override
  List<Object?> get props => [messageCode, debugMessage];
}
