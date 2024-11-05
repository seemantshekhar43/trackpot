import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/sizes.dart';
import '../../../../core/widgets/list_divider.dart';
import '../../../../init_dependencies.dart';
import '../../../group/presentation/pages/add_group.dart';
import '../../../group/presentation/pages/group_page.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/balance_card.dart';
import '../widgets/group_tile.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<DashboardPage> {
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
      create: (_) => serviceLocator<DashboardBloc>()..add(LoadDashboard()),
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
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is DashboardLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is DashboardError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error loading dashboard',
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
                          context.read<DashboardBloc>().add(LoadDashboard());
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (state is DashboardLoaded) {
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
                            return GestureDetector(
                              child: GroupTile(group: state.groups[groupIndex]),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    GroupPage.route(
                                        groupId:
                                            state.groups[groupIndex].groupId));
                              },
                            );
                          } else {
                            return const ListDivider();
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
