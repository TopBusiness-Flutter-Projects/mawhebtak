// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:mawhebtak/features/auth/new_account/data/model/user_types.dart';

sealed class NewAccountState {}

class NewAccountInitial extends NewAccountState {}

class LoadingGetUserTypesState extends NewAccountState {}

class ErrorGetUserTypesState extends NewAccountState {
  final String errorMessage;

  ErrorGetUserTypesState(this.errorMessage);
}

class LoadedGetUserTypesState extends NewAccountState {
  final MainRegisterUserTypes data;
  LoadedGetUserTypesState(this.data);
}class LoadingGetUserSubTypesState extends NewAccountState {}

class ErrorGetUserSubTypesState extends NewAccountState {
  final String errorMessage;

  ErrorGetUserSubTypesState(this.errorMessage);
}

class LoadedGetUserSubTypesState extends NewAccountState {
  final MainRegisterUserTypes data;
  LoadedGetUserSubTypesState(this.data);
}

class LoadingAddNewAccountState extends NewAccountState {}

class LoadedAddNewAccountState extends NewAccountState {}

class ErrorAddNewAccountState extends NewAccountState {
  final String errorMessage;

  ErrorAddNewAccountState(this.errorMessage);
}
