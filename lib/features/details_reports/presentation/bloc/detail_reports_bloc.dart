import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tcs/features/details_reports/domain/repositories/detail_reports_repository.dart';
import 'package:prueba_tcs/features/reports/domain/entities/report_entity.dart';
import 'package:shared/entities/status.dart';

part 'detail_reports_event.dart';
part 'detail_reports_state.dart';

class DetailReportsBloc extends Bloc<DetailReportsEvent, DetailReportsState> {
  final DetailReportsRepository _detailReportsRepository;

  DetailReportsBloc({required DetailReportsRepository detailReportsRepository})
    : _detailReportsRepository = detailReportsRepository,
      super(const DetailReportsState()) {
    on<ToggleEditEvent>(_toggleEdit);
    on<UpdateReportEvent>(_updateReport);
    on<GetReportByIdEvent>(_getReportById);
  }

  void _toggleEdit(ToggleEditEvent event, Emitter<DetailReportsState> emit) {
    emit(state.copyWith(isEditing: !state.isEditing));
  }

  void _updateReport(
    UpdateReportEvent event,
    Emitter<DetailReportsState> emit,
  ) {
    emit(state.copyWith(reportStatus: Status.loading));
    try {
      _detailReportsRepository.updateReport(event.report.id, event.report);
      emit(state.copyWith(reportStatus: Status.success));
    } catch (e) {
      emit(state.copyWith(reportStatus: Status.error));
    }
  }

  void _getReportById(
    GetReportByIdEvent event,
    Emitter<DetailReportsState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final ReportEntity report = await _detailReportsRepository.getReportById(
        event.id,
      );
      emit(state.copyWith(report: report, status: Status.success));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
