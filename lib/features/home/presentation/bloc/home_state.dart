part of 'home_bloc.dart';

class HomeState extends Equatable {
  final Status reportStatus;
  final Status deleteReportStatus;
  final List<ReportEntity> reports;
  final String error;
  const HomeState({
    this.reportStatus = Status.initital,
    this.deleteReportStatus = Status.initital,
    this.reports = const <ReportEntity>[],
    this.error = '',
  });

  HomeState copyWith({
    Status? reportStatus,
    Status? deleteReportStatus,
    List<ReportEntity>? reports,
    String? error,
  }) => HomeState(
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
