part of 'references_cubit.dart';

abstract class ReferenceState extends Equatable {
  const ReferenceState();

  @override
  List<Object?> get props => [];
}

class ReferenceInitial extends ReferenceState {
  const ReferenceInitial();
}

class ReferenceLoading extends ReferenceState {
  const ReferenceLoading();
}

class ReferenceLoaded extends ReferenceState {
  final ReferenceModel reference;

  const ReferenceLoaded(this.reference);

  @override
  List<Object?> get props => [reference];
}

class ReferenceError extends ReferenceState {
  final String messageCode;

  const ReferenceError(this.messageCode);

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (messageCode) {
      case 'REFERENCES_FETCH_SUCCESS':
        return localizations.references_fetch_success;
      case 'ERROR_SERVER':
        return localizations.error_server;
      case 'UNKNOWN_ERROR':
        return localizations.unknown_error;
      default:
        return localizations.unknown_error;
    }
  }

  @override
  List<Object?> get props => [messageCode];
}
