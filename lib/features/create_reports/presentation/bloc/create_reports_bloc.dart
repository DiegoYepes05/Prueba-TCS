import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tcs/features/create_reports/domain/repositories/create_reports_repository.dart';
import 'package:prueba_tcs/features/reports/domain/domain.dart';

part 'create_reports_event.dart';
part 'create_reports_state.dart';

class CreateReportsBloc extends Bloc<CreateReportsEvent, CreateReportsState> {
  final CreateReportsRepository _createReportsRepository;
  CreateReportsBloc({required CreateReportsRepository createReportsRepository})
    : _createReportsRepository = createReportsRepository,
      super(const CreateReportsState()) {
    on<CreateReportsSaveEvent>(_saveReport);
  }
  void _saveReport(
    CreateReportsSaveEvent event,
    Emitter<CreateReportsState> emit,
  ) async {
    try {
      emit(LoadingReportsState());
      await _createReportsRepository.saveReport(event.reportEntity);
      emit(SuccessReportsState());
    } catch (e) {
      emit(ErrorReportsState(message: e.toString()));
    }
  }
}
