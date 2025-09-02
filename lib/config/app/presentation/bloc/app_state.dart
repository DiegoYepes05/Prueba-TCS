part of 'app_bloc.dart';

enum AuthStatus { authenticated, unAuthenticated, initial }

class AppState extends Equatable {
  const AppState({this.authStatus = AuthStatus.initial, this.user});
  final AuthStatus authStatus;
  final User? user;
  AppState copyWith({AuthStatus? authStatus, User? user}) {
    return AppState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => <Object>[authStatus];
}
