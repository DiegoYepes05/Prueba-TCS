import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => <Object?>[];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess({required this.user});

  @override
  List<Object?> get props => <Object?>[user];
}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object?> get props => <Object?>[message];
}

// Estados específicos para diferentes tipos de errores
class AuthWeakPasswordError extends AuthError {
  const AuthWeakPasswordError() : super(message: 'La contraseña es muy débil');
}

class AuthEmailAlreadyInUseError extends AuthError {
  const AuthEmailAlreadyInUseError()
    : super(message: 'Este email ya está en uso');
}

class AuthUserNotFoundError extends AuthError {
  const AuthUserNotFoundError() : super(message: 'Usuario no encontrado');
}

class AuthWrongPasswordError extends AuthError {
  const AuthWrongPasswordError() : super(message: 'Contraseña incorrecta');
}

class AuthGenericError extends AuthError {
  const AuthGenericError() : super(message: 'Ocurrió un error inesperado');
}
