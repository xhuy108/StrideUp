part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  const HomeSuccess({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

final class HomeFailure extends HomeState {
  const HomeFailure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
