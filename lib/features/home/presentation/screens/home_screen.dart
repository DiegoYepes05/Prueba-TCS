import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tcs/features/home/presentation/bloc/home_bloc.dart';
import 'package:prueba_tcs/features/home/presentation/widgets/custom_line_chart.dart';
import 'package:prueba_tcs/features/home/presentation/widgets/register_tile.dart';
import 'package:prueba_tcs/features/service_locator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) =>
          sl<HomeBloc>()..add(HomeEventGetReports()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, HomeState state) {
          return Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    forceMaterialTransparency: true,
                    backgroundColor: Colors.transparent,
                    expandedHeight: 300,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      background: CustomLineChart(reports: state.reports),
                    ),
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.all(16),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'Ultimos movimientos',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList.builder(
                      itemCount: state.reports.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RegisterTile(report: state.reports[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
