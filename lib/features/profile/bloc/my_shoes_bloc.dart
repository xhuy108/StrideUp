import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:stride_up/models/shoes.dart';

// Trạng thái của MyShoesBloc
abstract class ShoesState extends Equatable {
  const ShoesState();

  @override
  List<Object?> get props => [];
}

class ShoesLoading extends ShoesState {}

class ShoesSuccess extends ShoesState {
  final List<Shoes> shoes;

  const ShoesSuccess(this.shoes);

  @override
  List<Object?> get props => [shoes];
}

class ShoesFailure extends ShoesState {
  final String message;

  const ShoesFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// Sự kiện của MyShoesBloc
abstract class ShoesEvent extends Equatable {
  const ShoesEvent();

  @override
  List<Object?> get props => [];
}

class FetchShoesByIds extends ShoesEvent {
  final List<String> shoeIds;

  const FetchShoesByIds(this.shoeIds);

  @override
  List<Object?> get props => [shoeIds];
}

class ShoesErrorEvent extends ShoesEvent {
  final String message;

  const ShoesErrorEvent(this.message);

  @override
  List<Object?> get props => [message];
}

// MyShoesRepository
class MyShoesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Shoes>> fetchShoesByIds(List<String> shoeIds) async {
    try {
      if (shoeIds.isNotEmpty) {
        final QuerySnapshot shoesSnapshot = await _firestore
            .collection('shoes')
            .where(FieldPath.documentId, whereIn: shoeIds)
            .get();

        final shoes = shoesSnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Shoes.fromJson(data);
        }).toList();
        return shoes;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Failed to fetch shoes: $e");
    }
  }
}

// MyShoesBloc
class MyShoesBloc extends Bloc<ShoesEvent, ShoesState> {
  final MyShoesRepository myShoesRepository;

  MyShoesBloc({required this.myShoesRepository}) : super(ShoesLoading()) {
    on<FetchShoesByIds>(_onFetchShoesByIds);
    on<ShoesErrorEvent>(_onShoesErrorEvent);
  }

  Future<void> _onFetchShoesByIds(
      FetchShoesByIds event, Emitter<ShoesState> emit) async {
    try {
      emit(ShoesLoading());
      final shoes = await myShoesRepository.fetchShoesByIds(event.shoeIds);
      emit(ShoesSuccess(shoes));
    } catch (e) {
      emit(ShoesFailure("Không thể lấy dữ liệu giày: ${e.toString()}"));
    }
  }

  void _onShoesErrorEvent(ShoesErrorEvent event, Emitter<ShoesState> emit) {
    emit(ShoesFailure(event.message));
  }
}
