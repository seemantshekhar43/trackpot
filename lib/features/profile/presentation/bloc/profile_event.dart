part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class SaveProfileEvent extends ProfileEvent {
}

class ChangeProfileEvent extends ProfileEvent {
  final User changedUser;

  ChangeProfileEvent({required this.changedUser});
}

class ChangeProfilePictureEvent extends ProfileEvent {
  final File updatedProfilePic;

  ChangeProfilePictureEvent({required this.updatedProfilePic});
}
