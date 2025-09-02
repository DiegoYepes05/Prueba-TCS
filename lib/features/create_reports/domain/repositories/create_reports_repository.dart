import 'package:prueba_tcs/features/home/domain/domain.dart';

abstract class CreateReportsRepository {
  Future<void> saveReport(ReportEntity reportEntity);
}
