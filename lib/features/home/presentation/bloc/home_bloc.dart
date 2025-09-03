import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tcs/features/home/domain/repositories/home_repsitories.dart';
import 'package:prueba_tcs/features/reports/domain/entities/report_entity.dart';
import 'package:shared/entities/status.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;
  HomeBloc({required HomeRepository homeRepository})
    : _homeRepository = homeRepository,
      super(const HomeState()) {
    on<HomeEventGetReports>(_getReports);
    on<HomeEventSetReports>(_setReports);
  }
  StreamSubscription<List<ReportEntity>>? _reportsSubscription;

  void _getReports(HomeEventGetReports event, Emitter<HomeState> emit) {
    _reportsSubscription = _homeRepository.getReports().listen((
      List<ReportEntity> reports,
    ) {
      add(HomeEventSetReports(reports: reports));
    });
  }

  void _setReports(HomeEventSetReports event, Emitter<HomeState> emit) {
    emit(state.copyWith(reports: event.reports));
  }

  @override
  Future<void> close() {
    _reportsSubscription?.cancel();
    return super.close();
  }
}
