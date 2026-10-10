import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

/// Centers content and caps its width on tablets / landscape.
class ContentConstraint extends StatelessWidget {
  const ContentConstraint({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
        // Fill up to the cap so narrow content stays start-aligned.
        child: SizedBox(width: double.infinity, child: child),
      ),
    );
  }
}
