part of 'detail_reports_bloc.dart';

sealed class DetailReportsEvent extends Equatable {
  const DetailReportsEvent();

  @override
  List<Object> get props => <Object>[];
}

class ToggleEditEvent extends DetailReportsEvent {}

class UpdateReportEvent extends DetailReportsEvent {
  final ReportEntity report;
  const UpdateReportEvent({required this.report});

  @override
  List<Object> get props => <Object>[report];
}

class GetReportByIdEvent extends DetailReportsEvent {
  final String id;
  const GetReportByIdEvent({required this.id});

  @override
  List<Object> get props => <Object>[id];
}
