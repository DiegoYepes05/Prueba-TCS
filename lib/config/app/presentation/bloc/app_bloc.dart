import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tcs/config/app/domain/repositories/app_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AppRepository appRepository})
    : _appRepository = appRepository,
      super(const AppState()) {
    on<GetUser>(_onGetUser);
    on<AuthStatusChanged>(_onAuthStatusChanged);
  }

  final AppRepository _appRepository;
  StreamSubscription<User?>? _subscription;

  void _onGetUser(GetUser event, Emitter<AppState> emit) {
    emit(state.copyWith(authStatus: AuthStatus.initial));
    _subscription = _appRepository.authStatus().listen((User? user) {
      add(AuthStatusChanged(user));
    });
  }

  void _onAuthStatusChanged(AuthStatusChanged event, Emitter<AppState> emit) {
    if (event.user != null) {
      emit(
        state.copyWith(authStatus: AuthStatus.authenticated, user: event.user),
      );
    } else {
      emit(state.copyWith(authStatus: AuthStatus.unAuthenticated, user: null));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
