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
import 'package:prueba_tcs/features/features.dart';
import 'package:prueba_tcs/features/home/domain/datasources/home_datasource.dart';
import 'package:prueba_tcs/features/home/domain/repositories/home_repository.dart';
import 'package:prueba_tcs/features/home/infrastructure/datasources/home_datasource_impl.dart';
import 'package:prueba_tcs/features/home/infrastructure/repositories/home_repository_impl.dart';
import 'package:prueba_tcs/features/home/presentation/bloc/home_bloc.dart';

GetIt sl = GetIt.instance;

void serviceLocatorInit() {
  // Datasources
  sl.registerLazySingleton<AuthDatasource>(() => AuthDatasourceImpl());
  sl.registerLazySingleton<AppDatasource>(() => AppDatasourceImpl());
  sl.registerLazySingleton<HomeDatasource>(() => HomeDatasourceImpl());
  sl.registerLazySingleton<CreateReportsDataSource>(
    () => CreateReportsDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepositories>(
    () => AuthRepositoriesImpl(datasource: sl<AuthDatasource>()),
  );
  sl.registerLazySingleton<AppRepository>(
    () => AppRepositoryImpl(datasource: sl<AppDatasource>()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(datasource: sl<HomeDatasource>()),
  );
  sl.registerLazySingleton<CreateReportsRepository>(
    () =>
        CreateReportsRepositoryImpl(dataSource: sl<CreateReportsDataSource>()),
  );

  // Bloc
  sl.registerLazySingleton<AppBloc>(
    () => AppBloc(appRepository: sl<AppRepository>()),
  );
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(homeRepository: sl<HomeRepository>()),
  );
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(authRepository: sl<AuthRepositories>()),
  );

  sl.registerFactory<CreateReportsBloc>(
    () => CreateReportsBloc(
      createReportsRepository: sl<CreateReportsRepository>(),
    ),
  );
}
