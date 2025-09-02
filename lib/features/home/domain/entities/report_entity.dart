import 'package:equatable/equatable.dart';

enum Category {
  income(name: 'Ingresos'),
  expense(name: 'Egresos');

  const Category({required this.name});
  final String name;
}

class ReportEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final Category category;

  const ReportEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
  });
  ReportEntity.empty()
    : this(
        id: '',
        title: '',
        description: '',
        amount: 0,
        date: DateTime.now(),
        category: Category.income,
      );

  ReportEntity copyWith({
    String? id,
    String? title,
    String? description,
    double? amount,
    DateTime? date,
    Category? category,
  }) => ReportEntity(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    category: category ?? this.category,
  );

  @override
  List<Object?> get props => <Object?>[
    id,
    title,
    description,
    amount,
    date,
    category,
  ];
  @override
  bool? get stringify => true;
}
