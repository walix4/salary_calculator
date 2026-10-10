import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/widgets/widgets.dart';
import '../features/onboarding/presentation/onboarding_controller.dart';
import '../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../features/paywall/presentation/premium_controller.dart';
import '../features/paywall/presentation/screens/paywall_screen.dart';
import 'main_shell.dart';

/// Shows the brand splash while loading, then onboarding on first launch
/// (followed once by the paywall), otherwise the main tabbed shell.
class AppGate extends ConsumerWidget {
  const AppGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completed = ref.watch(onboardingControllerProvider);
    final showPaywall = ref.watch(launchPaywallPendingProvider);
    final Widget child = completed.when(
      data: (done) {
        if (!done) return const OnboardingScreen();
        if (showPaywall) {
          return PaywallScreen(
            source: 'onboarding',
            // Closing continues into the app on the free tier.
            onClose: () =>
                ref.read(launchPaywallPendingProvider.notifier).state = false,
          );
        }
        return const MainShell();
      },
      loading: () => const BrandSplash(),
      // If the flag can't be read, don't block the app.
      error: (_, _) => const MainShell(),
    );
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: KeyedSubtree(key: ValueKey(child.runtimeType), child: child),
    );
  }
}
