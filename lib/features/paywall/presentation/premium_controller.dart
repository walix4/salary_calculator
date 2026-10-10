import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Number of salary records a free user can save.
const int freeRecordLimit = 3;

/// Whether the user has Premium. Always `false` until billing is wired: a
/// store/RevenueCat integration should drive this provider.
final isPremiumProvider = Provider<bool>((ref) => false);

/// Set when the intro finishes so the launch paywall is shown once, right
/// after onboarding. Cleared when the paywall is closed.
final launchPaywallPendingProvider = StateProvider<bool>((ref) => false);
