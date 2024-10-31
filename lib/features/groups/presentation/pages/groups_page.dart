import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackpot/features/groups/presentation/pages/add_group.dart';
import 'package:trackpot/init_dependencies.dart';

import '../../../../core/styles/sizes.dart';
import '../bloc/group_bloc.dart';
import '../widgets/balance_card.dart';
import '../widgets/group_tile.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showExtendedFab = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // Get current scroll position
    final scrollPosition = _scrollController.position.pixels;
    // Height of BalanceCard + Padding + Group Header (approximate)
    // Adjust this value based on your actual header height
    const headerHeight = KSizes.xl * 2;
    // Update FAB state based on scroll position
    if (scrollPosition >= headerHeight && _showExtendedFab) {
      setState(() => _showExtendedFab = false);
    } else if (scrollPosition < headerHeight && !_showExtendedFab) {
      setState(() => _showExtendedFab = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<GroupBloc>()..add(LoadGroup()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Group',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: KSizes.md),
              child: Icon(
                Icons.notifications,
                size: KSizes.iconMd,
              ),
            )
          ],
          elevation: 0.0,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          icon: const Icon(Icons.add),
          isExtended: _showExtendedFab,
          label: const Text('Add Expense'),
        ),
        body: SafeArea(
          child: BlocBuilder<GroupBloc, GroupState>(
            builder: (context, state) {
              if (state is GroupLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is GroupError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error loading groups',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: KSizes.sm),
                      Text(
                        state.message,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: KSizes.md),
                      ElevatedButton(
                        onPressed: () {
                          context.read<GroupBloc>().add(LoadGroup());
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (state is GroupLoaded) {
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          BalanceCard(
                            totalOwed: state.totalOwed,
                            totalOwedTo: state.totalOwedTo,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: KSizes.smd, horizontal: KSizes.md),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Your Groups',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context, AddGroupPage.route());
                                    },
                                    icon: const Icon(
                                      Icons.group_add,
                                      size: KSizes.iconMd,
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: state.groups.length * 2,
                        (context, index) {
                          if (index.isEven) {
                            final groupIndex = index ~/ 2;
                            if (groupIndex >= state.groups.length) return null;
                            return GroupTile(group: state.groups[groupIndex]);
                          } else {
                            return Divider(
                              color: Theme.of(context)
                                  .dividerColor
                                  .withOpacity(0.1),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
