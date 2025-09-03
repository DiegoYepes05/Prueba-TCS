import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_tcs/features/reports/domain/entities/report_entity.dart';

class RegisterTile extends StatelessWidget {
  final ReportEntity report;
  const RegisterTile({required this.report, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => context.push('/details/${report.id}'),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: Offset.zero,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              spacing: 12,
              children: <Widget>[
                Icon(report.category.icon, color: report.category.color),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      report.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      report.date.toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const Spacer(),
                Text(report.amount.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
