import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:prueba_tcs/config/extensions/stream_query_snapshots_extensions.dart';
import 'package:prueba_tcs/features/reports/domain/domain.dart';

class ReportsDatasourceImpl implements ReportsDatasource {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? get _uid => _auth.currentUser?.uid;
  @override
  Future<void> deleteReports(String id) async {
    try {
      await _firebase
          .collection('users')
          .doc(_uid)
          .collection('reports')
          .doc(id)
          .delete();
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw Exception('Error al eliminar el reporte');
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> getReports() {
    try {
      final Stream<List<Map<String, dynamic>>> response = _firebase
          .collection('users')
          .doc(_uid)
          .collection('reports')
          .snapshots()
          .toMap();
      return response;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw Exception('Error al obetener el reporte');
    }
  }
}
