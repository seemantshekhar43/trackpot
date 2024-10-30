import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../domain/entities/group.dart';
import '../../domain/usecases/create_group.dart';

part 'create_group_state.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  final CreateGroup createGroup;
  final AppUserCubit appUserCubit;

  CreateGroupCubit({
    required this.createGroup,
    required this.appUserCubit,
  }) : super(const CreateGroupInitial());

  Future<void> createNewGroup({
    required String name,
    String? category,
    String? groupPic,
    required String defaultCurrency,
  }) async {
    emit(const CreateGroupLoading());


      final user = (appUserCubit.state as AppUserAuthenticated).user;

      final group = Group(
        id: '', // Will be set by Appwrite
        name: name,
        category: category,
        groupPic: groupPic,
        currency: defaultCurrency,
        createdAt: DateTime.now(),
        createdBy: user,
        members: [user],
      );

      final createdGroup = await createGroup(group);
      createdGroup.fold((failure) => emit(CreateGroupError(message: failure.message)),
          (group) => emit(CreateGroupSuccess(group: group))
      );
  }
}
