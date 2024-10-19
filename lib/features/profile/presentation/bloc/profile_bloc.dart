import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/common/entities/user.dart';
import '../../../../core/exception/failure.dart';
import '../../domain/repository/update_user_data.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AppUserCubit _appUserCubit;
  final UpdateUserData _updateUserData;
   User _initialUser;
  ProfileBloc(
      {required AppUserCubit appUserCubit,
      required UpdateUserData updateUserData,
      required User initialUser})
      : _appUserCubit = appUserCubit,
        _updateUserData = updateUserData,
        _initialUser = initialUser,
        super(ProfileInitial(initialUser)) {
    on<SaveProfileEvent>(_updateUserProfileData);
    on<ChangeProfileEvent>(_changeProfileData);
  }
  void _updateUserProfileData(
      SaveProfileEvent event, Emitter<ProfileState> emit) async {
    final User updatedUser = state.user;
    emit(ProfileSaving(updatedUser));
    Either<Failure, void> res = await _updateUserData.call(state.user);
    res.fold((failure) => _updateFailure(updatedUser, failure.message, emit),
        (_) => _updateSuccess(updatedUser, emit));
  }

  void _updateSuccess(User user, Emitter<ProfileState> emit) {
    _appUserCubit.updateUserState(AppUserAuthenticated(user));
    _initialUser = user;
    emit(ProfileSaved(user));
  }

  void _updateFailure(User user, String message, Emitter<ProfileState> emit) {
    emit(ProfileError(user, message: message));
  }

  void _changeProfileData(
      ChangeProfileEvent event, Emitter<ProfileState> emit) {
    if (_isChanged(_initialUser, event.changedUser)) {
      emit(ProfileChanged(event.changedUser));
      print('changed');
    }else{
      emit(ProfileInitial(_initialUser));
    }
  }

  bool _isChanged(User initial, User changed) {
    print(initial.toString());
    print(changed.toString());
    return initial.firstName != changed.firstName ||
        initial.username != changed.username ||
        (initial.lastName ?? '') != (changed.lastName ?? '') ||
        (initial.phoneNumber ?? '') != (changed.phoneNumber ?? '') ||
        (initial.currency ?? '') != (changed.currency ?? '');
  }

}
