import 'package:cloud_firestore/cloud_firestore.dart';

extension QuerySnapshotMapper on Stream<QuerySnapshot<Map<String, dynamic>>> {
  Stream<List<Map<String, dynamic>>> toMap() {
    return map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.docs.map((
        QueryDocumentSnapshot<Map<String, dynamic>> doc,
      ) {
        final Map<String, dynamic> data = doc.data();
        return <String, dynamic>{'id': doc.id, ...data};
      }).toList();
    });
  }
}
