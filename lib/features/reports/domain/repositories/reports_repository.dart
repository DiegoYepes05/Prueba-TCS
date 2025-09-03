import 'package:prueba_tcs/features/reports/domain/domain.dart';

abstract interface class ReportsRepository {
  Stream<List<ReportEntity>> getReports();
  Future<void> deleteReports(String id);
}
