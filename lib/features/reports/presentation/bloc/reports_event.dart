part of 'reports_bloc.dart';

sealed class ReportsEvent extends Equatable {
  const ReportsEvent();

  @override
  List<Object> get props => <Object>[];
}

class GetReports extends ReportsEvent {}

class SuccessReports extends ReportsEvent {
  final List<ReportEntity> reports;
  const SuccessReports(this.reports);
}

class DeleteReport extends ReportsEvent {
  final String id;
  const DeleteReport(this.id);
}
