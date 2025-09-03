part of 'detail_reports_bloc.dart';

class DetailReportsState extends Equatable {
  const DetailReportsState({
    this.status = Status.initial,
    this.isEditing = false,
    this.report,
    this.reportStatus = Status.initial,
  });
  final Status status;
  final bool isEditing;
  final ReportEntity? report;
  final Status reportStatus;
  DetailReportsState copyWith({
    bool? isEditing,
    ReportEntity? report,
    Status? status,
    Status? reportStatus,
  }) => DetailReportsState(
    status: status ?? this.status,
    isEditing: isEditing ?? this.isEditing,
    report: report ?? this.report,
    reportStatus: reportStatus ?? this.reportStatus,
  );
  @override
  List<Object?> get props => <Object?>[isEditing, report, status, reportStatus];
}
