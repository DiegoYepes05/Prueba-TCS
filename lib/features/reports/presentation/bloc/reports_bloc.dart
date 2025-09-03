import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tcs/features/reports/domain/entities/report_entity.dart';
import 'package:prueba_tcs/features/reports/domain/repositories/reports_repository.dart';
import 'package:shared/shared.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  ReportsBloc({required ReportsRepository reportsRepository})
    : _reportsRepository = reportsRepository,
      super(const ReportsState()) {
    on<GetReports>(_getReports);
    on<SuccessReports>(_successReports);
    on<DeleteReport>(_deleteReport);
  }
  final ReportsRepository _reportsRepository;
  StreamSubscription<List<ReportEntity>>? _reportsSubscription;

  void _getReports(GetReports event, Emitter<ReportsState> emit) {
    _reportsSubscription = _reportsRepository.getReports().listen((
      List<ReportEntity> reports,
    ) {
      add(SuccessReports(reports));
    });
  }

  void _successReports(SuccessReports event, Emitter<ReportsState> emit) {
    emit(state.copyWith(reports: event.reports));
  }

  void _deleteReport(DeleteReport event, Emitter<ReportsState> emit) async {
    emit(state.copyWith(deleteReportStatus: Status.loading));
    try {
      await _reportsRepository.deleteReports(event.id);
      emit(state.copyWith(deleteReportStatus: Status.success));
    } catch (e) {
      emit(
        state.copyWith(deleteReportStatus: Status.error, error: e.toString()),
      );
    } finally {
      emit(state.copyWith(deleteReportStatus: Status.initial));
    }
  }

  @override
  Future<void> close() {
    _reportsSubscription?.cancel();
    return super.close();
  }
}
