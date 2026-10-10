import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/widgets/widgets.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/more/presentation/screens/more_screen.dart';
import '../features/salary_calculator/presentation/screens/salary_list_screen.dart';
import 'main_tab.dart';

export 'main_tab.dart';

/// Root scaffold with the floating pill navigation. Tabs are kept alive in an
/// [IndexedStack] so scroll position and state survive tab switches.
class MainShell extends ConsumerWidget {
  const MainShell({super.key});

  static const _items = [
    AppNavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Home',
    ),
    AppNavItem(
      icon: Icons.receipt_long_outlined,
      activeIcon: Icons.receipt_long_rounded,
      label: 'Records',
    ),
    AppNavItem(
      icon: Icons.account_circle_outlined,
      activeIcon: Icons.account_circle_rounded,
      label: 'More',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(mainTabProvider);
    return PopScope(
      // Back on a secondary tab returns Home instead of leaving the app.
      canPop: tab == MainTab.home,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) ref.read(mainTabProvider.notifier).state = MainTab.home;
      },
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: tab.index,
          children: const [HomeScreen(), SalaryListScreen(), MoreScreen()],
        ),
        bottomNavigationBar: AppBottomNav(
          items: _items,
          currentIndex: tab.index,
          onTap: (i) =>
              ref.read(mainTabProvider.notifier).state = MainTab.values[i],
        ),
      ),
    );
  }
}
