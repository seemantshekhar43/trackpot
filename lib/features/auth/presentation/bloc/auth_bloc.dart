import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackpot/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:trackpot/features/auth/domain/usecases/user_get_current_user.dart';
import 'package:trackpot/features/auth/domain/usecases/user_get_details.dart';
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
  AuthBloc({
    required UserSignup userSignup,
    required UserLogin userLogin,
    required UserGetDetails userGetDetails,
    required UserGetCurrentUser userGetCurrentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignup = userSignup,
        _userLogin = userLogin,
        _userGetDetails = userGetDetails,
        _getCurrentUser = userGetCurrentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignup);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
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
          : _emitAuthUserUnverified(user, emit);
    }
  }

  void _emitAuthSignUpSuccess(
    model.User user,
    Emitter<AuthState> emit,
  ) {
    emit(AuthSignUpSuccess(user));
  }

  void _emitAuthUserUnverified(
    model.User user,
    Emitter<AuthState> emit,
  ) {
    emit(AuthUserUnverified(user));
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _getCurrentUser(NoParams());
    if (res.isLeft()) {
      final failure = res.getLeft().toNullable();
      emit(AuthFailure(failure!.message));
    } else {
      final user = res.getRight().toNullable();
      await _fetchCurrentUserDetails(user!.$id, emit);
    }
  }

  void _emitAuthLoginSuccess(
    User user,
    Emitter<AuthState> emit,
  ) {
    _updateAppUserState(AppUserLoggedIn(user));
    emit(AuthLoginSuccess(user));
  }

  void _updateAppUserState(AppUserState state) {
    _appUserCubit.updateUserState(state);
  }

  Future<void> _fetchCurrentUserDetails(
    String id,
    Emitter<AuthState> emit,
  ) async {
    print('id : ${id}');
    final userDetails =
        await _userGetDetails.call(UserGetDetailsParams(id: id));
    userDetails.fold(
      (failure) {
        emit(AuthFailure(failure.message));
      },
      (user) => _emitAuthLoginSuccess(user, emit),
    );
  }
}
