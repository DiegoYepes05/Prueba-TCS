import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tcs/features/auth/domain/repositories/auth_repositories.dart';
import 'package:prueba_tcs/features/auth/presentation/bloc/auth_event.dart';
import 'package:prueba_tcs/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositories _authRepository;

  AuthBloc({required AuthRepositories authRepository})
    : _authRepository = authRepository,
      super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
  }

  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await _authRepository.loginUser(event.email, event.password);
    } catch (e) {
      emit(const AuthGenericError());
    }
  }

  Future<void> _onAuthRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await _authRepository.createUser(event.email, event.password);
    } catch (e) {
      emit(const AuthGenericError());
    }
  }
}
