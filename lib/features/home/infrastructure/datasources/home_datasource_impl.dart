import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prueba_tcs/config/extensions/stream_query_snapshots_extensions.dart';
import 'package:prueba_tcs/features/home/domain/datasources/home_datasource.dart';

class HomeDatasourceImpl implements HomeDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? get userId => _auth.currentUser?.uid;
  @override
  Stream<List<Map<String, dynamic>>> getReports() {
    try {
      return _firestore
          .collection('users')
          .doc(userId)
          .collection('reports')
          .snapshots()
          .toMap();
    } catch (e) {
      throw Exception(e);
    }
  }
}
