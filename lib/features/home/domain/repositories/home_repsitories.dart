import 'package:prueba_tcs/features/reports/domain/entities/report_entity.dart';

abstract class HomeRepository {
  Stream<List<ReportEntity>> getReports();
}
