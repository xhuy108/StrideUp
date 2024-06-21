part of 'user_shoes_cubit.dart';

sealed class UserShoesState extends Equatable {
  const UserShoesState();

  @override
  List<Object> get props => [];
}

final class UserShoesInitial extends UserShoesState {}

final class UserShoesLoading extends UserShoesState {}

final class UserShoesSuccess extends UserShoesState {
  const UserShoesSuccess({required this.shoes});

  final List<Shoes> shoes;

  @override
  List<Object> get props => [shoes];
}

final class UserShoesFailure extends UserShoesState {
  const UserShoesFailure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
