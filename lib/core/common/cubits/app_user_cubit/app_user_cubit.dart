import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());
}
