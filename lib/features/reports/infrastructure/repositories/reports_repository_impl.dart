import 'package:prueba_tcs/features/reports/domain/domain.dart';
import 'package:prueba_tcs/features/reports/infrastructure/mappers/report_mapper.dart';

class ReportsRepositoryImpl implements ReportsRepository {
  final ReportsDatasource datasource;

  ReportsRepositoryImpl({required this.datasource});
  @override
  Future<void> deleteReports(String id) {
    return datasource.deleteReports(id);
  }

  @override
  Stream<List<ReportEntity>> getReports() {
    final Stream<List<Map<String, dynamic>>> response = datasource.getReports();
    return response.asyncMap(
      (List<Map<String, dynamic>> listReport) => listReport
          .map((Map<String, dynamic> report) => ReportMapper.fromJson(report))
          .toList(),
    );
  }
}
