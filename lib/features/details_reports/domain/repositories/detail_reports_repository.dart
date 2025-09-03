import 'package:prueba_tcs/features/reports/domain/entities/report_entity.dart';

abstract class DetailReportsRepository {
  Future<ReportEntity> getReportById(String id);
  Future<void> updateReport(String id, ReportEntity report);
}
