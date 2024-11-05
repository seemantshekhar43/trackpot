import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/common/features/files/domain/repository/file_repository.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'app.dart';
import 'core/common/cubits/app_user/app_user_cubit.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<HomeBloc>(),
      ),
      RepositoryProvider<FileRepository>(
        create: (context) => serviceLocator<FileRepository>(),
      ),
    ],
    child: const MyApp(),
  ));
}
