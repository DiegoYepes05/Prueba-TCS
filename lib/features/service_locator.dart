import 'package:get_it/get_it.dart';
import 'package:prueba_tcs/config/app/domain/datasources/app_datasource.dart';
import 'package:prueba_tcs/config/app/domain/repositories/app_repository.dart';
import 'package:prueba_tcs/config/app/infrastructure/datasources/app_datasource_impl.dart';
import 'package:prueba_tcs/config/app/infrastructure/repositories/app_repository_impl.dart';
import 'package:prueba_tcs/config/app/presentation/bloc/app_bloc.dart';
import 'package:prueba_tcs/features/auth/domain/repositories/auth_repositories.dart';
import 'package:prueba_tcs/features/auth/infrastructure/datasources/auth_datasource_impl.dart';
import 'package:prueba_tcs/features/auth/infrastructure/repositories/auth_repositories_impl.dart';
import 'package:prueba_tcs/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:prueba_tcs/features/create_reports/domain/datasources/create_reports_datasource.dart';
import 'package:prueba_tcs/features/create_reports/domain/repositories/create_reports_repository.dart';
import 'package:prueba_tcs/features/create_reports/infrastructure/datasources/create_reports_datasource_impl.dart';
import 'package:prueba_tcs/features/create_reports/infrastructure/repositories/create_reports_repository_impl.dart';
import 'package:prueba_tcs/features/create_reports/presentation/bloc/create_reports_bloc.dart';
import 'package:prueba_tcs/features/details_reports/domain/datasources/detail_reports_datasource.dart';
import 'package:prueba_tcs/features/details_reports/domain/repositories/detail_reports_repository.dart';
import 'package:prueba_tcs/features/details_reports/infrastructure/datasources/detail_reports_datasource_impl.dart';
import 'package:prueba_tcs/features/details_reports/infrastructure/repositories/detail_reports_repository_impl.dart';
import 'package:prueba_tcs/features/details_reports/presentation/bloc/detail_reports_bloc.dart';
import 'package:prueba_tcs/features/features.dart';
import 'package:prueba_tcs/features/home/domain/datasources/home_datasource.dart';
import 'package:prueba_tcs/features/home/domain/repositories/home_repsitories.dart';
import 'package:prueba_tcs/features/home/infrastructure/datasources/home_datasource_impl.dart';
import 'package:prueba_tcs/features/home/infrastructure/repositories/home_repsoitories_impl.dart';
import 'package:prueba_tcs/features/home/presentation/bloc/home_bloc.dart';
import 'package:prueba_tcs/features/reports/domain/datasources/reports_datasource.dart';
import 'package:prueba_tcs/features/reports/domain/repositories/reports_repository.dart';
import 'package:prueba_tcs/features/reports/infrastructure/datasources/reports_datasource_impl.dart';
import 'package:prueba_tcs/features/reports/infrastructure/repositories/reports_repository_impl.dart';
import 'package:prueba_tcs/features/reports/presentation/bloc/reports_bloc.dart';

GetIt sl = GetIt.instance;

void serviceLocatorInit() {
  // Datasources
  sl.registerLazySingleton<AuthDatasource>(() => AuthDatasourceImpl());
  sl.registerLazySingleton<AppDatasource>(() => AppDatasourceImpl());
  sl.registerLazySingleton<DetailReportsDataSource>(
    () => DetailReportsDatasourceImpl(),
  );
  sl.registerLazySingleton<ReportsDatasource>(() => ReportsDatasourceImpl());
  sl.registerLazySingleton<CreateReportsDataSource>(
    () => CreateReportsDataSourceImpl(),
  );
  sl.registerLazySingleton<HomeDatasource>(() => HomeDatasourceImpl());

  // Repositories
  sl.registerLazySingleton<AuthRepositories>(
    () => AuthRepositoriesImpl(datasource: sl<AuthDatasource>()),
  );
  sl.registerLazySingleton<DetailReportsRepository>(
    () => DetailReportsRepositoryImpl(
      detailReportsDataSource: sl<DetailReportsDataSource>(),
    ),
  );
  sl.registerLazySingleton<AppRepository>(
    () => AppRepositoryImpl(datasource: sl<AppDatasource>()),
  );
  sl.registerLazySingleton<ReportsRepository>(
    () => ReportsRepositoryImpl(datasource: sl<ReportsDatasource>()),
  );
  sl.registerLazySingleton<CreateReportsRepository>(
    () =>
        CreateReportsRepositoryImpl(dataSource: sl<CreateReportsDataSource>()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(datasource: sl<HomeDatasource>()),
  );

  // Bloc
  sl.registerLazySingleton<AppBloc>(
    () => AppBloc(appRepository: sl<AppRepository>()),
  );
  sl.registerFactory<ReportsBloc>(
    () => ReportsBloc(reportsRepository: sl<ReportsRepository>()),
  );
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(authRepository: sl<AuthRepositories>()),
  );

  sl.registerFactory<HomeBloc>(
    () => HomeBloc(homeRepository: sl<HomeRepository>()),
  );

  sl.registerFactory<DetailReportsBloc>(
    () => DetailReportsBloc(
      detailReportsRepository: sl<DetailReportsRepository>(),
    ),
  );

  sl.registerFactory<CreateReportsBloc>(
    () => CreateReportsBloc(
      createReportsRepository: sl<CreateReportsRepository>(),
    ),
  );
}
