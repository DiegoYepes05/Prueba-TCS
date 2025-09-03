import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_tcs/config/extensions/app_toastification_extension.dart';
import 'package:prueba_tcs/features/reports/domain/entities/report_entity.dart';
import 'package:prueba_tcs/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:shared/shared.dart';

class ReportsListScreen extends StatefulWidget {
  final List<ReportEntity> reports;
  const ReportsListScreen({required this.reports, super.key});

  @override
  State<ReportsListScreen> createState() => _ReportsListScreenState();
}

class _ReportsListScreenState extends State<ReportsListScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.reports.isEmpty) {
      return const Center(child: Text('No hay reportes'));
    }
    return BlocConsumer<ReportsBloc, ReportsState>(
      listener: (BuildContext context, ReportsState state) {
        switch (state.deleteReportStatus) {
          case Status.error:
            context.showErrorToastification(message: state.error);
            break;
          case Status.success:
            context.showSuccessToastification(message: 'Reporte eliminado');
            break;
          default:
            break;
        }
      },
      builder: (BuildContext context, ReportsState state) {
        return ListView.separated(
          itemCount: widget.reports.length,
          itemBuilder: (BuildContext context, int index) {
            final ReportEntity report = widget.reports[index];
            return GestureDetector(
              onTap: () => context.push('/details/${report.id}'),
              child: Dismissible(
                confirmDismiss: (DismissDirection direction) async {
                  context.read<ReportsBloc>().add(DeleteReport(report.id));
                  return false;
                },
                key: ValueKey<String>(report.id),
                direction: DismissDirection.startToEnd,
                background: Container(
                  padding: const EdgeInsets.only(left: 8.0),
                  color: Colors.red[400],
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Eliminar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                child: ListTile(
                  title: Text(report.title),
                  subtitle: Text(report.amount.toString()),
                  trailing: Text(report.date.toString()),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        );
      },
    );
  }
}
