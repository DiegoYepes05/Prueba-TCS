part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.reports = const <ReportEntity>[],
    this.status = Status.initial,
  });

  final List<ReportEntity> reports;
  final Status status;

  HomeState copyWith({List<ReportEntity>? reports, Status? status}) {
    return HomeState(
      reports: reports ?? this.reports,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => <Object>[reports, status];
}
