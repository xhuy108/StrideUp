import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stride_up/features/home/repositories/user_repository.dart';
import 'package:stride_up/models/user.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;

  HomeBloc({required this.userRepository}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchUserEvent>((event, emit) async {
      emit(HomeLoading());

      final result = await userRepository.getUser();

      result.fold(
        (failure) => emit(HomeFailure(message: failure.message)),
        (user) => emit(HomeSuccess(user: user)),
      );
    });
  }
}
