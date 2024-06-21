import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stride_up/features/home/repositories/user_repository.dart';
import 'package:stride_up/models/shoes.dart';

part 'user_shoes_state.dart';

class UserShoesCubit extends Cubit<UserShoesState> {
  final UserRepository userRepository;

  UserShoesCubit({required this.userRepository}) : super(UserShoesInitial());

  void fetchUserShoes() async {
    emit(UserShoesLoading());

    final res = await userRepository.fetchUserShoes();

    res.fold(
      (error) => emit(UserShoesFailure(message: error.message)),
      (shoes) => emit(UserShoesSuccess(shoes: shoes)),
    );
  }
}
