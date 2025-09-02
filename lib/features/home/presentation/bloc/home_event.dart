part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => <Object>[];
}

class GetReports extends HomeEvent {}

class SuccessReports extends HomeEvent {
  final List<ReportEntity> reports;
  const SuccessReports(this.reports);
}

class DeleteReport extends HomeEvent {
  final String id;
  const DeleteReport(this.id);
}
