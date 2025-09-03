import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_tcs/features/reports/domain/entities/report_entity.dart';
import 'package:prueba_tcs/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:prueba_tcs/features/reports/presentation/screens/reports_list_screen.dart';
import 'package:prueba_tcs/features/service_locator.dart';
import 'package:shared/shared.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReportsBloc>(
      create: (BuildContext context) => sl<ReportsBloc>()..add(GetReports()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Reportes', style: TextStyle(color: Colors.white)),

          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 50),
            child: BlocSelector<ReportsBloc, ReportsState, Status>(
              selector: (ReportsState state) {
                return state.reportStatus;
              },
              builder: (BuildContext context, Status state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: SegmentedTabControl(
                    controller: tabController,
                    tabTextColor: Colors.black87,
                    selectedTabTextColor: Colors.white,
                    squeezeIntensity: 2,

                    barDecoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),

                    tabs: <SegmentTab>[
                      SegmentTab(
                        label: 'INGRESOS',
                        color: Colors.green[400],
                        backgroundColor: Colors.green[50],
                      ),
                      SegmentTab(
                        label: 'EGRESOS',
                        color: Colors.red[400],
                        backgroundColor: Colors.red[50],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        body:
            BlocSelector<
              ReportsBloc,
              ReportsState,
              (List<ReportEntity>, Status, String)
            >(
              selector: (ReportsState state) {
                return (state.reports, state.reportStatus, state.error);
              },
              builder:
                  (
                    BuildContext context,
                    (List<ReportEntity>, Status, String) state,
                  ) {
                    final List<ReportEntity> incomeReports = state.$1
                        .where(
                          (ReportEntity report) =>
                              report.category == Category.income,
                        )
                        .toList();
                    final List<ReportEntity> expenseReports = state.$1
                        .where(
                          (ReportEntity report) =>
                              report.category == Category.expense,
                        )
                        .toList();
                    if (state.$2 == Status.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.$2 == Status.error) {
                      return Center(child: Text(state.$3));
                    }
                    return TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: <Widget>[
                        ReportsListScreen(reports: incomeReports),
                        ReportsListScreen(reports: expenseReports),
                      ],
                    );
                  },
            ),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 0,
          onPressed: () {
            switch (tabController.index) {
              case 0:
                context.push('/reports/create/0');
                break;
              case 1:
                context.push('/reports/create/1');
                break;
            }
          },
          label: const Text('Crear', style: TextStyle(color: Colors.white)),
          icon: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
