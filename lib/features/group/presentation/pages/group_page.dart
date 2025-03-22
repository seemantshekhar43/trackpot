import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/sizes.dart';
import '../../../../init_dependencies.dart';
import '../../../dashboard/presentation/widgets/group_avatar.dart';
import '../../../groupInfo/presentation/bloc/group_info_bloc.dart';
import '../../../groupInfo/presentation/pages/group_info_page.dart';
import '../bloc/group_page_bloc.dart';
import '../widgets/balance_tab.dart';
import '../widgets/expense_tab.dart';
import '../widgets/totals_tab.dart';

class GroupPage extends StatefulWidget {
  final String groupId;

  static route({required String groupId}) => MaterialPageRoute(
    builder: (context) => GroupPage(groupId: groupId),
  );

  const GroupPage({super.key, required this.groupId});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging || _tabController.index != _tabController.previousIndex) {
      context.read<GroupPageBloc>().add(ChangeGroupTab(_tabController.index));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      serviceLocator<GroupPageBloc>()..add(LoadGroupPage(widget.groupId)),
      child: BlocConsumer<GroupPageBloc, GroupPageState>(
        listener: (context, state) {
          if (state is GroupPageLoaded && _tabController.index != state.activeTab) {
            _tabController.animateTo(state.activeTab);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                state is GroupPageLoaded ? state.group.name : 'Group',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    if (state is GroupPageLoaded) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => GroupInfoBloc(
                              appUserCubit: serviceLocator(),
                              deleteGroup: serviceLocator(),
                              removeMember: serviceLocator(),
                              groupPageBloc: context.read<GroupPageBloc>(),
                              initialGroup: state.group,
                            ),
                            child: GroupInfoPage(initialGroup: state.group),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            body: _buildBody(context, state),
            floatingActionButton: state is GroupPageLoaded && state.activeTab == 0
                ? FloatingActionButton.extended(
              onPressed: () {
                // TODO: Navigate to Add Expense page
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Expense'),
            )
                : null,
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, GroupPageState state) {
    if (state is GroupPageInitial) {
      return const SizedBox.shrink();
    }

    if (state is GroupPageLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is GroupPageError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${state.message}'),
            const SizedBox(height: KSizes.md),
            ElevatedButton(
              onPressed: () => context
                  .read<GroupPageBloc>()
                  .add(LoadGroupPage(widget.groupId)),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is GroupPageLoaded) {
      return Column(
        children: [
          // Group Info Section
          _buildGroupInfoSection(context, state),

          // Tab Bar
          _buildTabBar(context, state),

          // Tab Content with swipe functionality
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ExpenseTab(group: state.group),
                BalanceTab(group: state.group),
                TotalsTab(group: state.group),
              ],
            ),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildGroupInfoSection(BuildContext context, GroupPageLoaded state) {
    // For now, let's set a mock user balance
    const userBalance = -125.75; // Negative means you owe

    return Container(
      padding: const EdgeInsets.all(KSizes.sm),
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          // Group Icon and Name
          Row(
            children: [
              GroupAvatar(
                imageId: state.group.groupPic,
                category: state.group.category,
                width: KSizes.containerSquareSm,
                height: KSizes.containerSquareSm,
              ),
              const SizedBox(width: KSizes.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.group.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${state.group.members.length} members',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: KSizes.md),

          // Balance Card
          // Container(
          //   padding: const EdgeInsets.all(KSizes.md),
          //   decoration: BoxDecoration(
          //     color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
          //     borderRadius: BorderRadius.circular(KSizes.borderRadiusMd),
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'Your balance',
          //         style: Theme.of(context).textTheme.bodySmall,
          //       ),
          //       const SizedBox(height: KSizes.xs),
          //       Text(
          //         FinanceUtils.formatAmount(userBalance),
          //         style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          //           fontWeight: FontWeight.bold,
          //           color: FinanceUtils.getBalanceColor(userBalance),
          //         ),
          //       ),
          //       const SizedBox(height: KSizes.xs),
          //       Text(
          //         userBalance >= 0
          //             ? 'You are owed money overall'
          //             : 'You owe money to members',
          //         style: Theme.of(context).textTheme.bodySmall,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context, GroupPageLoaded state) {
    final tabs = ['Expenses', 'Balances', 'Totals'];

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        onTap: (index) {
          context.read<GroupPageBloc>().add(ChangeGroupTab(index));
        },
        tabs: tabs.map((title) {
          final index = tabs.indexOf(title);
          final isActive = state.activeTab == index;

          return Tab(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: KSizes.sm),
              child: Text(
                title,
                style: TextStyle(
                  color: isActive
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).textTheme.bodyLarge?.color,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
        indicatorColor: Theme.of(context).colorScheme.primary,
        indicatorWeight: 2,
      ),
    );
  }
}