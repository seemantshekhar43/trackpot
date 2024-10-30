part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initProfile();
  _initGroup();

  Client client = Client();
  client
      .setEndpoint(AppSecrets.endPoint)
      .setProject(AppSecrets.projectId)
      .setSelfSigned(status: true);

  serviceLocator.registerLazySingleton(() => client);

  serviceLocator.registerLazySingleton<Account>(
    () => Account(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<Databases>(
    () => Databases(serviceLocator()),
  );
  serviceLocator
      .registerFactory<InternetConnection>(() => InternetConnection());

  serviceLocator
  .registerLazySingleton<Storage>(() => Storage(serviceLocator()));

  // core

  serviceLocator.registerFactory<NetworkConnectionChecker>(
    () => NetworkConnectionCheckerImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<AppUserCubit>(
    () => AppUserCubit(),
  );
}

void _initAuth() {
  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator(), serviceLocator()),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory<UserSignup>(
      () => UserSignup(
        serviceLocator(),
      ),
    )
    ..registerFactory<UserLogin>(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory<UserGetDetails>(
      () => UserGetDetails(serviceLocator()),
    )
    ..registerFactory<UserGetCurrentUser>(
      () => UserGetCurrentUser(serviceLocator()),
    )
    ..registerFactory<UserLogOut>(
      () => UserLogOut(serviceLocator()),
    )

    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignup: serviceLocator(),
        userLogin: serviceLocator(),
        userGetDetails: serviceLocator(),
        userGetCurrentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
        userLogOut: serviceLocator(),
      ),
    )
    ..registerLazySingleton(() => HomeBloc());
}

void _initProfile() {
  serviceLocator
    // dataSource
    ..registerFactory<ProfileRemoteDataSource>(
        () => ProfileRemoteDataSourceImpl(appwriteDB: serviceLocator()))
    //repository
    ..registerFactory<ProfileRepository>(
        () => ProfileRepositoryImpl(profileRemoteDataSource: serviceLocator()))
    //usecases
    ..registerFactory<UpdateUserData>(() => UpdateUserData(serviceLocator()))
    //bloc
    ..registerFactoryParam<ProfileBloc, User, void>((user, _) => ProfileBloc(
        appUserCubit: serviceLocator(),
        updateUserData: serviceLocator(),
        initialUser: user));
}

void _initGroup() {
  serviceLocator
    // datasource
    ..registerLazySingleton<GroupRemoteDataSource>(
        () => GroupRemoteDataSourceImpl(serviceLocator(), serviceLocator()))
    // repository
    ..registerLazySingleton<GroupRepository>(
        () => GroupRepositoryImpl(serviceLocator()))
    // usecases
    ..registerLazySingleton<CreateGroup>(() => CreateGroup(serviceLocator()))
    ..registerLazySingleton<GetUserGroups>(
        () => GetUserGroups(serviceLocator()))
    ..registerLazySingleton<GetUserBalanceStats>(
        () => GetUserBalanceStats(serviceLocator()))
    //cubit
    ..registerFactory(() => CreateGroupCubit(
        createGroup: serviceLocator(), appUserCubit: serviceLocator()));
}
