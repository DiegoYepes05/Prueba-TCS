import 'package:prueba_tcs/features/home/domain/datasources/home_datasource.dart';
import 'package:prueba_tcs/features/home/domain/repositories/home_repsitories.dart';
import 'package:prueba_tcs/features/reports/domain/entities/report_entity.dart';
import 'package:prueba_tcs/features/reports/infrastructure/mappers/report_mapper.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource datasource;
  HomeRepositoryImpl({required this.datasource});
  @override
  Stream<List<ReportEntity>> getReports() {
    final Stream<List<Map<String, dynamic>>> response = datasource.getReports();
    return response.asyncMap((List<Map<String, dynamic>> register) {
      return register
          .map((Map<String, dynamic> e) => ReportMapper.fromJson(e))
          .toList();
    });
  }
}
