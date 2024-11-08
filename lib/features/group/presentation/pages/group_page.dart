import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../init_dependencies.dart';
import '../../../groupInfo/presentation/bloc/group_info_bloc.dart';
import '../../../groupInfo/presentation/pages/group_info_page.dart';
import '../bloc/group_page_bloc.dart';

class GroupPage extends StatelessWidget {
  final String groupId;

  static route({required String groupId}) => MaterialPageRoute(
        builder: (context) => GroupPage(groupId: groupId),
      );

  const GroupPage({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocator<GroupPageBloc>()..add(LoadGroupPage(groupId)),
      child: BlocBuilder<GroupPageBloc, GroupPageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Group'),
            ),
            body: switch (state) {
              GroupPageInitial() => const SizedBox.shrink(),
              GroupPageLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              GroupPageLoaded(:final group) => Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) => GroupInfoBloc(
                                appUserCubit: serviceLocator(),
                                deleteGroup: serviceLocator(),
                                removeMember: serviceLocator(),
                                groupPageBloc: context.read<GroupPageBloc>(),
                                initialGroup: group,
                              ),
                              child: GroupInfoPage(initialGroup: group),
                            ),
                          ),
                        );
                      },
                      child: Text(group.name)),
                ),
              GroupPageError(:final message) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: $message'),
                      ElevatedButton(
                        onPressed: () => context
                            .read<GroupPageBloc>()
                            .add(LoadGroupPage(groupId)),
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
