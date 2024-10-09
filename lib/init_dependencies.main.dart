part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  Client client = Client();
  client
      .setEndpoint(AppSecrets.endPoint)
      .setProject(AppSecrets.projectId)
      .setSelfSigned(status: true);

  serviceLocator.registerLazySingleton(() => client);

  serviceLocator.registerLazySingleton(
        () => Account(serviceLocator()),
  );

  serviceLocator.registerFactory(() => InternetConnection());

  // core

  serviceLocator.registerFactory<NetworkConnectionChecker>(
        () => NetworkConnectionCheckerImpl(
      serviceLocator(),
    ),
  );
}

void _initAuth() {
  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
  // Repository
    ..registerFactory<AuthRepository>(
          () => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
  // Usecases
    ..registerFactory(
          () => UserSignup(
        serviceLocator(),
      ),
    )
    ..registerFactory(
          () => UserLogin(
        serviceLocator(),
      ),
    )

  // Bloc
    ..registerLazySingleton(
          () => AuthBloc(
        userSignup: serviceLocator(),
        userLogin: serviceLocator(),
      ),
    );
}
