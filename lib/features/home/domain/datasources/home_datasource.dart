abstract interface class HomeDatasource {
  Stream<List<Map<String, dynamic>>> getReports();
  Future<void> deleteReports(String id);
}
