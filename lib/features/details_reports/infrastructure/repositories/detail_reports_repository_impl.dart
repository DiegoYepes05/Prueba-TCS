import 'package:prueba_tcs/features/details_reports/domain/datasources/detail_reports_datasource.dart';
import 'package:prueba_tcs/features/details_reports/domain/repositories/detail_reports_repository.dart';
import 'package:prueba_tcs/features/reports/domain/entities/report_entity.dart';
import 'package:prueba_tcs/features/reports/infrastructure/infrastructure.dart';

class DetailReportsRepositoryImpl implements DetailReportsRepository {
  final DetailReportsDataSource detailReportsDataSource;
  DetailReportsRepositoryImpl({required this.detailReportsDataSource});
  @override
  Future<ReportEntity> getReportById(String id) async {
    final Map<String, dynamic> report = await detailReportsDataSource
        .getReportById(id);
    return ReportMapper.fromJson(report);
  }

  @override
  Future<void> updateReport(String id, ReportEntity report) async {
    final ReportMapper reportMap = ReportMapper.fromEntity(report);
    await detailReportsDataSource.updateReport(id, reportMap.toJson());
  }
}
