part of 'reports_bloc.dart';

class ReportsState extends Equatable {
  final Status reportStatus;
  final Status deleteReportStatus;
  final List<ReportEntity> reports;
  final String error;
  const ReportsState({
    this.reportStatus = Status.initial,
    this.deleteReportStatus = Status.initial,
    this.reports = const <ReportEntity>[],
    this.error = '',
  });

  ReportsState copyWith({
    Status? reportStatus,
    Status? deleteReportStatus,
    List<ReportEntity>? reports,
    String? error,
  }) => ReportsState(
    reportStatus: reportStatus ?? this.reportStatus,
    deleteReportStatus: deleteReportStatus ?? this.deleteReportStatus,
    reports: reports ?? this.reports,
    error: error ?? this.error,
  );
  @override
  List<Object> get props => <Object>[
    reportStatus,
    deleteReportStatus,
    reports,
    error,
  ];
}
