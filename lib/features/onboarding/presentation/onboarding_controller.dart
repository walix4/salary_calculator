import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../paywall/presentation/premium_controller.dart';
import '../data/onboarding_storage.dart';

final onboardingStorageProvider = Provider<OnboardingStorage>(
  (ref) => const OnboardingStorage(),
);

/// `true` once the user has finished (or skipped) the intro.
class OnboardingController extends AsyncNotifier<bool> {
  @override
  Future<bool> build() => ref.read(onboardingStorageProvider).isCompleted();

  Future<void> complete() async {
    await ref.read(onboardingStorageProvider).setCompleted(true);
    // Show the paywall once, right after the intro.
    if (!ref.read(isPremiumProvider)) {
      ref.read(launchPaywallPendingProvider.notifier).state = true;
    }
    state = const AsyncData(true);
  }

  /// Shows the intro again (used from the More tab).
  Future<void> reset() async {
    await ref.read(onboardingStorageProvider).setCompleted(false);
    state = const AsyncData(false);
  }
}

final onboardingControllerProvider =
    AsyncNotifierProvider<OnboardingController, bool>(OnboardingController.new);
