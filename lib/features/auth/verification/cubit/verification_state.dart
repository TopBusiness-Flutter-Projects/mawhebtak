import 'package:equatable/equatable.dart';

class VerificationInitial extends VerificationState {}

class VerificationState extends Equatable {
  final String? errorMessage;

  const VerificationState({this.errorMessage});

  VerificationState copyWith({String? errorMessage}) {
    return VerificationState(
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [errorMessage];
}

class ValidateDataStateLoading extends VerificationState {}

class ValidateDataStateLoaded extends VerificationState {}

class ValidateDataStateError extends VerificationState {}

class VerificationStateUpdated extends VerificationState {}
