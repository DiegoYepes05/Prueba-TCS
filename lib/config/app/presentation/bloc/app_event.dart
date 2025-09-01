part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AuthStatusChanged extends AppEvent {
  final User? user;
  const AuthStatusChanged(this.user);
}

class GetUser extends AppEvent {}
