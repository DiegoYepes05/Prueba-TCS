abstract class DetailReportsDataSource {
  Future<Map<String, dynamic>> getReportById(String id);
  Future<void> updateReport(String id, Map<String, dynamic> report);
}
