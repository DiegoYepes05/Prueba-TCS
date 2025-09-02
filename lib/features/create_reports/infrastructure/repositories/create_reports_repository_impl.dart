import 'package:prueba_tcs/features/create_reports/domain/datasources/create_reports_datasource.dart';
import 'package:prueba_tcs/features/create_reports/domain/repositories/create_reports_repository.dart';
import 'package:prueba_tcs/features/home/domain/entities/report_entity.dart';
import 'package:prueba_tcs/features/home/infrastructure/mappers/report_mapper.dart';

class CreateReportsRepositoryImpl implements CreateReportsRepository {
  final CreateReportsDataSource dataSource;
  CreateReportsRepositoryImpl({required this.dataSource});
  @override
  Future<void> saveReport(ReportEntity reportEntity) {
    final ReportMapper report = ReportMapper.fromEntity(reportEntity);
    return dataSource.saveReport(report.toJson());
  }
}
