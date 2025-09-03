import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prueba_tcs/features/reports/domain/domain.dart';

class ReportMapper extends ReportEntity {
  const ReportMapper({
    required super.id,
    required super.title,
    required super.description,
    required super.amount,
    required super.date,
    required super.category,
  });

  static ReportEntity fromJson(Map<String, dynamic> json) {
    final Timestamp timestamp = json['date'] as Timestamp;

    return ReportMapper(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      amount: (json['amount'] as num).toDouble(),
      date: timestamp.toDate(),
      category: Category.values[json['category'] as int],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'amount': amount,
      'date': Timestamp.fromDate(date),
      'category': category.index,
    };
  }

  static ReportMapper fromEntity(ReportEntity report) {
    return ReportMapper(
      id: report.id,
      title: report.title,
      description: report.description,
      amount: report.amount,
      date: report.date,
      category: report.category,
    );
  }
}
