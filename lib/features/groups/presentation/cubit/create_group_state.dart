part of 'create_group_cubit.dart';

abstract class CreateGroupState extends Equatable {
  const CreateGroupState();

  @override
  List<Object?> get props => [];
}

class CreateGroupInitial extends CreateGroupState {
  const CreateGroupInitial();
}

class CreateGroupLoading extends CreateGroupState {
  const CreateGroupLoading();
}

class CreateGroupSuccess extends CreateGroupState {
  final Group group;

  const CreateGroupSuccess({required this.group});

  @override
  List<Object?> get props => [group];
}

class CreateGroupError extends CreateGroupState {
  final String message;

  const CreateGroupError({required this.message});

  @override
  List<Object?> get props => [message];
}
