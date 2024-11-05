import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../init_dependencies.dart';
import '../bloc/group_bloc.dart';
import 'group_info_page.dart';

class GroupPage extends StatelessWidget {
  final String groupId;
  static route({required String groupId}) => MaterialPageRoute(
        builder: (context) => GroupPage(
          groupId: groupId,
        ),
      );
  const GroupPage({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<GroupBloc>()..add(LoadGroup(groupId)),
      child: BlocBuilder<GroupBloc, GroupState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Group'),
            ),
            body: switch (state) {
              GroupInitial() => const SizedBox.shrink(),
              GroupLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              GroupLoaded(:final group) => Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<GroupBloc>(),
                                child: GroupInfoPage(initialGroup: group),
                              ),
                            ));
                      },
                      child: Text('${group.name}')),
                ),
              GroupError(:final message) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: $message'),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<GroupBloc>().add(LoadGroup(groupId)),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
            },
          );
        },
      ),
    );
  }
}
