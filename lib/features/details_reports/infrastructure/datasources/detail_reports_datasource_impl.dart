import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prueba_tcs/features/details_reports/domain/datasources/detail_reports_datasource.dart';

class DetailReportsDatasourceImpl implements DetailReportsDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? get _user => _firebaseAuth.currentUser?.uid;

  @override
  Future<Map<String, dynamic>> getReportById(String id) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc = await _firestore
          .collection('users')
          .doc(_user)
          .collection('reports')
          .doc(id)
          .get();
      return <String, dynamic>{'id': doc.id, ...doc.data()!};
    } catch (e) {
      throw Exception('Error al obtener el reporte');
    }
  }

  @override
  Future<void> updateReport(String id, Map<String, dynamic> report) {
    try {
      return _firestore
          .collection('users')
          .doc(_user)
          .collection('reports')
          .doc(id)
          .update(report);
    } catch (e) {
      throw Exception('Error al actualizar el reporte');
    }
  }
}
