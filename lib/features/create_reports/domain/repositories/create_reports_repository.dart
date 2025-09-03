import 'package:prueba_tcs/features/reports/domain/domain.dart';

abstract class CreateReportsRepository {
  Future<void> saveReport(ReportEntity reportEntity);
}
