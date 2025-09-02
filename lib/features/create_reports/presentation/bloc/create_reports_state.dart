part of 'create_reports_bloc.dart';

class CreateReportsState extends Equatable {
  const CreateReportsState();

  @override
  List<Object> get props => <Object>[];
}

class LoadingReportsState extends CreateReportsState {}

class SuccessReportsState extends CreateReportsState {}

class ErrorReportsState extends CreateReportsState {
  final String message;
  const ErrorReportsState({required this.message});
}
