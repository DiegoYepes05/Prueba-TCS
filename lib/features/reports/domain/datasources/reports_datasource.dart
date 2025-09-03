abstract interface class ReportsDatasource {
  Stream<List<Map<String, dynamic>>> getReports();
  Future<void> deleteReports(String id);
}
