import 'package:prueba_tcs/features/home/domain/domain.dart';
import 'package:prueba_tcs/features/home/infrastructure/mappers/report_mapper.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource datasource;

  HomeRepositoryImpl({required this.datasource});
  @override
  Future<void> deleteReports(String id) {
    return datasource.deleteReports(id);
  }

  @override
  Stream<List<ReportEntity>> getReports() {
    final Stream<List<Map<String, dynamic>>> response = datasource.getReports();
    return response.asyncMap(
      (List<Map<String, dynamic>> listReport) => listReport
          .map(
            (Map<String, dynamic> report) =>
                ReportMapper.reportTojsonEntity(report),
          )
          .toList(),
    );
  }
}
