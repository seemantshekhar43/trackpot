part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSignUpSuccess extends AuthState {
  final model.User user;
  const AuthSignUpSuccess(this.user);
}

final class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
}

final class AuthUserUnverified extends AuthState {
  final model.User user;
  const AuthUserUnverified(this.user);
}

final class AuthLoginSuccess extends AuthState {
  final User user;
  const AuthLoginSuccess(this.user);
}

final class AuthLogOutSuccess extends AuthState {
  const AuthLogOutSuccess();
}

final class AuthUserDoesNotExist extends AuthState {}
