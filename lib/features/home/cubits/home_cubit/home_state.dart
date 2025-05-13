import 'package:equatable/equatable.dart';
import 'package:mawhebtak/features/home/data/models/home_model.dart';
import 'package:mawhebtak/features/home/data/models/top_talents_model.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeStateLoading extends HomeState {}

final class HomeStateError extends HomeState {
  final String? errorMessage;
  const HomeStateError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

final class HomeStateLoaded extends HomeState {
  final HomeModel? homeModel;
  const HomeStateLoaded(this.homeModel);

  @override
  List<Object?> get props => [homeModel];
}



