import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stride_up/features/auth/repositories/auth_repository.dart';
import 'package:stride_up/models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthLoading());
    });
    on<AuthSignUpWithEmailEvent>(_signUpWithEmail);
    on<AuthLogInEvent>(_logIn);
    on<AuthLogOutEvent>(_logOut);
  }

  void _signUpWithEmail(
    AuthSignUpWithEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _authRepository.signUpWithEmailAndPassword(
      event.email,
      event.password,
      event.username,
      event.phoneNumber,
    );
    result.fold(
      (failure) => emit(
        AuthFailure(message: failure.errorMessage),
      ),
      (_) => emit(
        AuthSuccess(
          user: User(email: event.email, id: '1', name: 'John Doe'),
        ),
      ),
    );
  }

  void _logIn(
    AuthLogInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _authRepository.logIn(
      event.email,
      event.password,
    );
    result.fold(
      (failure) => emit(
        AuthFailure(message: failure.errorMessage),
      ),
      (_) => emit(
        AuthSuccess(
          user: User(email: event.email, id: '1', name: 'John Doe'),
        ),
      ),
    );
  }

  void _logOut(
    AuthLogOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _authRepository.logOut();
    result.fold(
      (failure) => emit(
        AuthFailure(message: failure.errorMessage),
      ),
      (_) => emit(
        AuthSuccess(
          user: User(email: '', id: '1', name: 'John Doe'),
        ),
      ),
    );
  }
}
