part of 'shoes_bloc.dart';

sealed class ShoesState extends Equatable {
  const ShoesState();

  @override
  List<Object> get props => [];
}

final class ShoesInitial extends ShoesState {}

final class ShoesLoading extends ShoesState {}

final class ShoesSuccess extends ShoesState {
  const ShoesSuccess({required this.shoes});

  final List<Shoes> shoes;

  @override
  List<Object> get props => [shoes];
}

final class ShoesFailure extends ShoesState {
  const ShoesFailure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
