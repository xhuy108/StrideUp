part of 'shoes_bloc.dart';

sealed class ShoesEvent extends Equatable {
  const ShoesEvent();

  @override
  List<Object> get props => [];
}

class FetchShoesEvent extends ShoesEvent {
  const FetchShoesEvent();
}
