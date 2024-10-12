import 'package:appwrite/appwrite.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'features/auth/domain/usecases/user_log_out.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'core/network/network_connection_checker.dart';
import 'core/secrets/app_secrets.dart';
import 'features/auth/domain/usecases/user_get_current_user.dart';
import 'features/auth/domain/usecases/user_get_details.dart';
import 'core/common/cubits/app_user/app_user_cubit.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/usecases/user_login.dart';
import 'features/auth/domain/usecases/user_signup.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

part 'init_dependencies.main.dart';