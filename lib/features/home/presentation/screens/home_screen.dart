import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_tcs/features/home/domain/entities/report_entity.dart';
import 'package:prueba_tcs/features/home/presentation/bloc/home_bloc.dart';
import 'package:prueba_tcs/features/reports/presentation/screens/reports_screen.dart';
import 'package:prueba_tcs/features/service_locator.dart';
import 'package:shared/shared.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) => sl<HomeBloc>()..add(GetReports()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reportes', style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout, color: Colors.white),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 50),
            child: BlocSelector<HomeBloc, HomeState, Status>(
              selector: (HomeState state) {
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
              HomeBloc,
              HomeState,
              (List<ReportEntity>, Status, String)
            >(
              selector: (HomeState state) {
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
                        ReportsScreen(reports: incomeReports),
                        ReportsScreen(reports: expenseReports),
                      ],
                    );
                  },
            ),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 0,
          onPressed: () {
            switch (tabController.index) {
              case 0:
                context.push('/home/create/0');
                break;
              case 1:
                context.push('/home/create/1');
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
