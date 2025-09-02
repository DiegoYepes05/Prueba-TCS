import 'package:prueba_tcs/features/home/domain/domain.dart';

abstract interface class HomeRepository {
  Stream<List<ReportEntity>> getReports();
  Future<void> deleteReports(String id);
}
