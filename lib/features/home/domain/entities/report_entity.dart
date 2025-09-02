enum Category { income, expense }

class ReportEntity {
  final String id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final Category category;

  ReportEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
  });
}
