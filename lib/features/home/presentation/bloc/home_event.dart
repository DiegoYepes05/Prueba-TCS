part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => <Object>[];
}

class HomeEventGetReports extends HomeEvent {}

class HomeEventSetReports extends HomeEvent {
  final List<ReportEntity> reports;
  const HomeEventSetReports({required this.reports});
}
