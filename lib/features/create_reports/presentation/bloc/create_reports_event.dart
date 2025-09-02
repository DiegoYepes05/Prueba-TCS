part of 'create_reports_bloc.dart';

sealed class CreateReportsEvent extends Equatable {
  const CreateReportsEvent();

  @override
  List<Object> get props => <Object>[];
}

class CreateReportsSaveEvent extends CreateReportsEvent {
  final ReportEntity reportEntity;
  const CreateReportsSaveEvent({required this.reportEntity});
}
