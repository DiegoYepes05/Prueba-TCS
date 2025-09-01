// features/auth/presentation/bloc/auth_bloc.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tcs/features/auth/domain/repositories/auth_repositories.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositories authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
  }

  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final result = await authRepository.loginUser(
        event.email,
        event.password,
      );

      if (result is User) {
        emit(AuthSuccess(user: result));
      } else if (result == 1) {
        emit(const AuthUserNotFoundError());
      } else if (result == 2) {
        emit(const AuthWrongPasswordError());
      } else {
        emit(const AuthGenericError());
      }
    } catch (e) {
      emit(AuthGenericError());
    }
  }

  Future<void> _onAuthRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final result = await authRepository.createUser(
        event.email,
        event.password,
      );

      if (result is User) {
        emit(AuthSuccess(user: result));
      } else if (result == 1) {
        emit(const AuthWeakPasswordError());
      } else if (result == 2) {
        emit(const AuthEmailAlreadyInUseError());
      } else {
        emit(const AuthGenericError());
      }
    } catch (e) {
      emit(const AuthGenericError());
    }
  }
}
