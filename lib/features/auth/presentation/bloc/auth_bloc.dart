import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/user_login.dart';
import '../../domain/usecases/user_signup.dart';
import 'package:appwrite/models.dart' as model;
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserLogin _userLogin;
  AuthBloc({
    required UserSignup userSignup,
    required UserLogin userLogin,
  })  : _userSignup = userSignup,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignup);
    on<AuthLogin>(_onAuthLogin);
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
      (user) => _emitAuthSuccess(user, emit),
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

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => r.emailVerification
          ? _emitAuthSuccess(r, emit)
          : _emitAuthUserUnverified(r, emit),
    );
  }

  void _emitAuthSuccess(
    model.User user,
    Emitter<AuthState> emit,
  ) {
    emit(AuthSuccess(user));
  }

  void _emitAuthUserUnverified(
    model.User user,
    Emitter<AuthState> emit,
  ) {
    emit(AuthUserUnverified(user));
  }
}
