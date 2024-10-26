import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:trackpot/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:trackpot/core/constants/exception_constants.dart';
import 'package:trackpot/core/exception/failure.dart';
import 'package:trackpot/features/auth/domain/usecases/user_get_current_user.dart';
import 'package:trackpot/features/auth/domain/usecases/user_get_details.dart';
import 'package:trackpot/features/auth/domain/usecases/user_log_out.dart';
import '../../../../core/common/entities/user.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/user_login.dart';
import '../../domain/usecases/user_signup.dart';
import 'package:appwrite/models.dart' as model;
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserLogin _userLogin;
  final UserGetDetails _userGetDetails;
  final UserGetCurrentUser _getCurrentUser;
  final AppUserCubit _appUserCubit;
  final UserLogOut _userLogOut;
  AuthBloc({
    required UserSignup userSignup,
    required UserLogin userLogin,
    required UserGetDetails userGetDetails,
    required UserGetCurrentUser userGetCurrentUser,
    required AppUserCubit appUserCubit,
    required UserLogOut userLogOut,
  })  : _userSignup = userSignup,
        _userLogin = userLogin,
        _userGetDetails = userGetDetails,
        _getCurrentUser = userGetCurrentUser,
        _appUserCubit = appUserCubit,
        _userLogOut = userLogOut,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignup);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
    on<AuthLogOut>(_onAuthLogOut);
  }

  void _onAuthSignup(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userSignup(
      UserSignupParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSignUpSuccess(user, emit),
    );
  }

  void _onAuthLogin(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    if (res.isLeft()) {
      final failure = res.getLeft().toNullable();
      emit(AuthFailure(failure!.message));
    } else {
      final user = res.getRight().toNullable();
      user!.emailVerification
          ? await _fetchCurrentUserDetails(user.$id, emit)
          : await _emitAuthUserUnverified(user, emit);
    }
  }

  void _emitAuthSignUpSuccess(
    model.User user,
    Emitter<AuthState> emit,
  ) {
    emit(AuthSignUpSuccess(user));
  }

  Future<void> _emitAuthUserUnverified(
    model.User user,
    Emitter<AuthState> emit,
  ) async {
    await _clearSession();
    emit(AuthUserUnverified(user));
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _getCurrentUser(NoParams());
    if (res.isLeft()) {
      final failure = res.getLeft().toNullable();
      if (ExceptionConstants.userSessionNotFound == failure?.type) {
        emit(AuthUserDoesNotExist());
      } else {
        emit(AuthFailure(failure!.message));
      }
    } else {
      final user = res.getRight().toNullable();
      await _fetchCurrentUserDetails(user!.$id, emit);
    }
  }

  void _emitAuthLoginSuccess(
    User user,
    Emitter<AuthState> emit,
  ) {
    _updateAppUserState(AppUserAuthenticated(user));
    emit(AuthLoginSuccess(user));
  }

  void _updateAppUserState(AppUserState state) {
    _appUserCubit.updateUserState(state);
  }

  Future<void> _fetchCurrentUserDetails(
    String id,
    Emitter<AuthState> emit,
  ) async {
    final userDetails =
        await _userGetDetails.call(UserGetDetailsParams(id: id));
    if (userDetails.isLeft()) {
      final failure = userDetails.getLeft().toNullable();
      await _clearSession();
      if (ExceptionConstants.userSessionNotFound == failure?.type) {
        emit(AuthUserDoesNotExist());
      } else {
        emit(AuthFailure(failure!.message));
      }
    } else {
      final user = userDetails.getRight().toNullable();
      _emitAuthLoginSuccess(user!, emit);
    }
  }

  void _onAuthLogOut(
    AuthLogOut event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _clearSession();

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitLogOutSuccess(emit),
    );
  }

  Future<Either<Failure, void>> _clearSession() async {
    return await _userLogOut.call(NoParams());
  }

  void _emitLogOutSuccess(
    Emitter<AuthState> emit,
  ) {
    _updateAppUserState(AppUserInitial());
    emit(const AuthLogOutSuccess());
  }
}
