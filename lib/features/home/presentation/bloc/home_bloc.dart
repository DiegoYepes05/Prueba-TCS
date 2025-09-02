import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tcs/features/home/domain/entities/report_entity.dart';
import 'package:prueba_tcs/features/home/domain/repositories/home_repository.dart';
import 'package:shared/shared.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required HomeRepository homeRepository})
    : _homeRepository = homeRepository,
      super(const HomeState()) {
    on<GetReports>(_getReports);
    on<SuccessReports>(_successReports);
    on<DeleteReport>(_deleteReport);
  }
  final HomeRepository _homeRepository;
  StreamSubscription<List<ReportEntity>>? _reportsSubscription;

  void _getReports(GetReports event, Emitter<HomeState> emit) {
    _reportsSubscription = _homeRepository.getReports().listen((
      List<ReportEntity> reports,
    ) {
      add(SuccessReports(reports));
    });
  }

  void _successReports(SuccessReports event, Emitter<HomeState> emit) {
    emit(state.copyWith(reports: event.reports));
  }

  void _deleteReport(DeleteReport event, Emitter<HomeState> emit) {
    emit(state.copyWith(deleteReportStatus: Status.loading));
    try {
      _homeRepository.deleteReports(event.id);
      emit(state.copyWith(deleteReportStatus: Status.success));
    } catch (e) {
      emit(
        state.copyWith(deleteReportStatus: Status.error, error: e.toString()),
      );
    }
  }

  @override
  Future<void> close() {
    _reportsSubscription?.cancel();
    return super.close();
  }
}
