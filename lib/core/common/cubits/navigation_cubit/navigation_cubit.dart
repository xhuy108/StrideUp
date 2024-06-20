import 'package:bloc/bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  void selectItem(int index) => emit(index);

  void reset() => emit(0);
}
