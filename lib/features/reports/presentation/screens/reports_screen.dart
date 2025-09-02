import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tcs/config/extensions/app_toastification_extension.dart';
import 'package:prueba_tcs/features/home/domain/entities/report_entity.dart';
import 'package:prueba_tcs/features/home/presentation/bloc/home_bloc.dart';
import 'package:shared/shared.dart';

class ReportsScreen extends StatefulWidget {
  final List<ReportEntity> reports;
  const ReportsScreen({required this.reports, super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.reports.isEmpty) {
      return const Center(child: Text('No hay reportes'));
    }
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (BuildContext context, HomeState state) {
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
      builder: (BuildContext context, HomeState state) {
        return ListView.separated(
          itemCount: widget.reports.length,
          itemBuilder: (BuildContext context, int index) {
            final ReportEntity report = widget.reports[index];
            return Dismissible(
              onDismissed: (DismissDirection direction) {
                showAdaptiveDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog.adaptive(
                      title: const Text('Eliminar reporte'),
                      content: const Text(
                        '¿Estas seguro de eliminar el reporte?',
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<HomeBloc>().add(
                              DeleteReport(report.id),
                            );
                            Navigator.pop(context);
                          },
                          child: const Text('Eliminar'),
                        ),
                      ],
                    );
                  },
                );
              },
              key: ValueKey<String>(report.id),
              direction: DismissDirection.startToEnd,
              background: Container(
                padding: const EdgeInsets.only(left: 8.0),
                color: Colors.red[400],
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Elimnar', style: TextStyle(color: Colors.white)),
                ),
              ),
              child: ListTile(
                title: Text(report.title),
                subtitle: Text(report.amount.toString()),
                trailing: Icon(Icons.edit_document, color: Colors.green[200]),
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
