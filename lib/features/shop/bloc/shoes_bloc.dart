import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stride_up/features/shop/repositories/shop_repository.dart';
import 'package:stride_up/models/shoes.dart';

part 'shoes_event.dart';
part 'shoes_state.dart';

class ShoesBloc extends Bloc<ShoesEvent, ShoesState> {
  final ShopRepository _shopRepository;

  ShoesBloc({required ShopRepository shopRepository})
      : _shopRepository = shopRepository,
        super(ShoesInitial()) {
    on<ShoesEvent>((event, emit) {});

    on<FetchShoesEvent>(_fetchShoes);
  }

  void _fetchShoes(FetchShoesEvent event, Emitter<ShoesState> emit) async {
    emit(ShoesLoading());
    final result = await _shopRepository.fetchShoes();

    result.fold(
      (failure) => emit(
        ShoesFailure(message: failure.errorMessage),
      ),
      (shoes) => emit(
        ShoesSuccess(shoes: shoes),
      ),
    );
  }
}
