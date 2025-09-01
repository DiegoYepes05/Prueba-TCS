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
import 'package:prueba_tcs/features/features.dart';

GetIt sl = GetIt.instance;

void serviceLocatorInit() {
  // Datasources
  sl.registerLazySingleton<AuthDatasource>(() => AuthDatasourceImpl());
  sl.registerLazySingleton<AppDatasource>(() => AppDatasourceImpl());
  // Repositories
  sl.registerLazySingleton<AuthRepositories>(
    () => AuthRepositoriesImpl(datasource: sl<AuthDatasource>()),
  );
  sl.registerLazySingleton<AppRepository>(
    () => AppRepositoryImpl(datasource: sl<AppDatasource>()),
  );

  // Bloc
  sl.registerLazySingleton<AppBloc>(
    () => AppBloc(appRepository: sl<AppRepository>()),
  );
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(authRepository: sl<AuthRepositories>()),
  );
}
