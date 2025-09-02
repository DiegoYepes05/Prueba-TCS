import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prueba_tcs/features/home/domain/domain.dart';

class ReportMapper {
  static ReportEntity reportTojsonEntity(Map<String, dynamic> json) {
    final Timestamp timestamp = json['date'] as Timestamp;
    return ReportEntity(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      amount: (json['amount'] as num).toDouble(),
      date: timestamp.toDate(),
      category: Category.values[json['category'] as int],
    );
  }
}
