part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {
  final User user;

  const ProfileState(this.user);

}

final class ProfileInitial extends ProfileState {
  const ProfileInitial(super.user);
}

class ProfileSaving extends ProfileState {
  const ProfileSaving(super.user);
}

class ProfileSaved extends ProfileState {
  const ProfileSaved(super.user);
}

class ProfileChanged extends ProfileState {
  const ProfileChanged(super.user);
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(super.user, {required this.message});
}
