import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => <Object?>[email, password];
}

class AuthRegisterRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthRegisterRequested({required this.email, required this.password});

  @override
  List<Object?> get props => <Object?>[email, password];
}
