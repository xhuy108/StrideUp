part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignUpWithEmailEvent extends AuthEvent {
  const AuthSignUpWithEmailEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class AuthLogInEvent extends AuthEvent {
  const AuthLogInEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class AuthLogOutEvent extends AuthEvent {
  const AuthLogOutEvent();
}
