import 'package:flutter/material.dart';

import '../../../../core/styles/sizes.dart';
import '../widgets/balance_card.dart';
import '../widgets/group_tile.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Groups',
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
        label: const Text('Add Group'),
      ),
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const BalanceCard(),
                  Padding(
                    padding: const EdgeInsets.all(KSizes.md),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your Groups',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index.isEven) {
                    return const GroupTile();
                  } else {
                    return Divider(
                      color: Theme.of(context).dividerColor.withOpacity(0.1),
                    );
                  }
                },
                childCount: 19, // 10 items + 9 dividers
              ),
            ),
          ],
        ),
      ),
    );
  }
}
