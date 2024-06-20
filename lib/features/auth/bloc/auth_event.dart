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
    required this.username,
    required this.phoneNumber,
  });

  final String email;
  final String password;
  final String username;
  final String phoneNumber;

  @override
  List<Object> get props => [email, password, username, phoneNumber];
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
