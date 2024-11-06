part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initUsers();
  _initProfile();
  _initDashboard();
  _initGroup();
  _initAddMember();

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

  serviceLocator.registerLazySingleton<Realtime>(
    () => Realtime(serviceLocator()),
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

  // file
  serviceLocator.registerLazySingleton<FileRemoteDataSource>(
      () => FileRemoteDatasourceImpl(storage: serviceLocator()));
  serviceLocator.registerLazySingleton<FileRepository>(
      () => FileRepositoryImpl(remoteDataSource: serviceLocator()));
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
    ..registerFactory<ProfileRemoteDataSource>(() =>
        ProfileRemoteDataSourceImpl(
            appwriteDB: serviceLocator(), storage: serviceLocator()))
    //repository
    ..registerFactory<ProfileRepository>(
        () => ProfileRepositoryImpl(profileRemoteDataSource: serviceLocator()))
    //usecases
    ..registerFactory<UpdateUserData>(() => UpdateUserData(serviceLocator()))
    ..registerFactory<UpdateProfilePic>(
        () => UpdateProfilePic(serviceLocator()))

    //bloc
    ..registerFactoryParam<ProfileBloc, User, void>((user, _) => ProfileBloc(
        appUserCubit: serviceLocator(),
        updateUserData: serviceLocator(),
        updateProfilePic: serviceLocator(),
        initialUser: user));
}

void _initDashboard() {
  serviceLocator
    // datasource
    ..registerLazySingleton<GroupRemoteDataSource>(() =>
        GroupRemoteDataSourceImpl(
            serviceLocator(), serviceLocator(), serviceLocator()))
    ..registerLazySingleton<GroupMemoryCacheDataSource>(
        () => GroupMemoryCacheDataSourceImpl())
    // repository
    ..registerLazySingleton<GroupRepository>(() => GroupRepositoryImpl(
        groupRemoteDataSource: serviceLocator(),
        groupMemoryCacheDataSource: serviceLocator(),
        networkConnectionChecker: serviceLocator()))
    // usecases
    ..registerLazySingleton<CreateGroup>(() => CreateGroup(serviceLocator()))
    ..registerLazySingleton<WatchUserGroups>(
        () => WatchUserGroups(serviceLocator()))
    ..registerLazySingleton<GetUserGroups>(
        () => GetUserGroups(serviceLocator()))
    ..registerLazySingleton<GetUserBalanceStats>(
        () => GetUserBalanceStats(serviceLocator()))
    ..registerLazySingleton<UpdateGroup>(() => UpdateGroup(serviceLocator()))
    //cubit
    ..registerFactory<CreateGroupCubit>(() => CreateGroupCubit(
        createGroup: serviceLocator<CreateGroup>(),
        appUserCubit: serviceLocator<AppUserCubit>(),
        updateGroup: serviceLocator<UpdateGroup>()))
    //bloc
    ..registerFactory<DashboardBloc>(() => DashboardBloc(serviceLocator(),
        serviceLocator(), serviceLocator(), serviceLocator()));
}

void _initGroup() {
  serviceLocator
    //usecases
    ..registerFactory<WatchGroupById>(() => WatchGroupById(serviceLocator()))

    //bloc
    ..registerFactory<GroupBloc>(
        () => GroupBloc(watchGroupById: serviceLocator()));
}

void _initAddMember() {
  serviceLocator
    //usecases
    ..registerFactory<GetAllUsers>(() => GetAllUsers(serviceLocator()))
    ..registerFactory<AddMember>(() => AddMember(serviceLocator()))

    //cubit
    ..registerFactoryParam<AddMembersCubit, Group, void>(
        (group, _) => AddMembersCubit(
              getAllUsers: serviceLocator(),
              addMember: serviceLocator(),
              group: group,
            ));
}

void _initUsers() {
  serviceLocator
    //datasources
    ..registerFactory<UsersRemoteDatasource>(
        () => UsersRemoteDatasourceImpl(db: serviceLocator()))
    // repository
    ..registerFactory<UsersRepository>(
        () => UsersRepositoryImpl(usersRemoteDatasource: serviceLocator()));
}
