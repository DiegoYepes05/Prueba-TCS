import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prueba_tcs/features/create_reports/domain/datasources/create_reports_datasource.dart';

class CreateReportsDataSourceImpl implements CreateReportsDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? get userId => _auth.currentUser?.uid;
  @override
  Future<void> saveReport(Map<String, dynamic> report) {
    try {
      return _firestore
          .collection('users')
          .doc(userId)
          .collection('reports')
          .add(report);
    } catch (e) {
      throw Exception(e);
    }
  }
}
