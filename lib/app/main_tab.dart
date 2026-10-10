import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tabs in the bottom navigation, in display order.
enum MainTab { home, records, more }

/// Currently selected tab. Screens can switch tabs (e.g. Home "View all").
final mainTabProvider = StateProvider<MainTab>((ref) => MainTab.home);
