import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import 'paywall_palette.dart';

class _Feature {
  const _Feature(this.title, this.icon, this.tint);

  final String title;
  final IconData icon;
  final Color tint;
}

/// Real app features only. Ordered so neighbours never share a colour,
/// including across the wrap from last to first.
const List<_Feature> _features = [
  _Feature('Unlimited records', Icons.all_inclusive, AppColors.pinkStrong),
  _Feature('Live preview', Icons.bolt, AppColors.purple),
  _Feature('Full breakdown', Icons.receipt_long, AppColors.success),
  _Feature('PF & EOBI', Icons.savings, PaywallPalette.coinDeep),
  _Feature('Tax deductions', Icons.account_balance, AppColors.pinkStrong),
  _Feature('Private on device', Icons.lock, AppColors.purple),
  _Feature('Edit anytime', Icons.edit, AppColors.success),
];

/// Endless, slowly drifting row of feature chips whose edges fade out. With
/// animations disabled it holds still and scrolls by hand instead.
class PaywallFeatureStrip extends StatefulWidget {
  const PaywallFeatureStrip({super.key});

  static const double tileWidth = 80;
  static const double spacing = 10;

  /// Logical pixels per second: slow enough to read each label.
  static const double speed = 26;

  @override
  State<PaywallFeatureStrip> createState() => _PaywallFeatureStripState();
}

class _PaywallFeatureStripState extends State<PaywallFeatureStrip>
    with SingleTickerProviderStateMixin {
  static final double _loopWidth =
      _features.length *
      (PaywallFeatureStrip.tileWidth + PaywallFeatureStrip.spacing);

  late final AnimationController _drift = AnimationController(
    vsync: this,
    duration: Duration(
      milliseconds: (_loopWidth / PaywallFeatureStrip.speed * 1000).round(),
    ),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _drift.stop();
    } else if (!_drift.isAnimating) {
      _drift.repeat();
    }
  }

  @override
  void dispose() {
    _drift.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final label =
        'Included: ${_features.map((feature) => feature.title).join(', ')}';

    final Widget strip;
    if (reduceMotion) {
      strip = const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: AppSpacing.screenPadding,
        child: _ChipRow(copies: 1),
      );
    } else {
      // Enough copies to cover the widest content width at any loop offset.
      final width = MediaQuery.sizeOf(context).width;
      final copies =
          (width.clamp(0, AppSpacing.maxContentWidth) / _loopWidth).ceil() + 1;
      strip = UnconstrainedBox(
        constrainedAxis: Axis.vertical,
        alignment: Alignment.centerLeft,
        clipBehavior: Clip.hardEdge,
        child: AnimatedBuilder(
          animation: _drift,
          builder: (context, child) => Transform.translate(
            offset: Offset(AppSpacing.screen - _drift.value * _loopWidth, 0),
            child: child,
          ),
          child: _ChipRow(copies: copies),
        ),
      );
    }

    return Semantics(
      container: true,
      label: label,
      excludeSemantics: true,
      child: ShaderMask(
        blendMode: BlendMode.dstIn,
        shaderCallback: (bounds) {
          final fade = bounds.width <= 0
              ? 0.0
              : (AppSpacing.screen / bounds.width).clamp(0.0, 0.5);
          return LinearGradient(
            colors: const [
              Color(0x00000000),
              Color(0xFF000000),
              Color(0xFF000000),
              Color(0x00000000),
            ],
            stops: [0, fade, 1 - fade, 1],
          ).createShader(bounds);
        },
        // Labels sit in fixed 80pt chips: keep them at base size so words never
        // break mid-way. The full list is in the semantics label above.
        child: MediaQuery.withClampedTextScaling(
          maxScaleFactor: 1,
          child: strip,
        ),
      ),
    );
  }
}

class _ChipRow extends StatelessWidget {
  const _ChipRow({required this.copies});

  final int copies;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var copy = 0; copy < copies; copy++)
          for (final feature in _features) ...[
            _FeatureChip(feature: feature),
            const SizedBox(width: PaywallFeatureStrip.spacing),
          ],
      ],
    );
  }
}

/// Icon token rising above a pastel card, with a two-line label beneath.
class _FeatureChip extends StatelessWidget {
  const _FeatureChip({required this.feature});

  final _Feature feature;

  static const double _token = 40;
  static const double _tokenRise = 18;
  static const double _labelSize = 12.5;
  static const double _labelHeight = 1.2;

  @override
  Widget build(BuildContext context) {
    final textScaler = MediaQuery.textScalerOf(context);
    return SizedBox(
      width: PaywallFeatureStrip.tileWidth,
      child: Stack(
        children: [
          Positioned.fill(
            top: _tokenRise,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: feature.tint.withValues(alpha: 0.12),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 9),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: _token,
                  height: _token,
                  decoration: BoxDecoration(
                    color: feature.tint,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.onInk.withValues(alpha: 0.9),
                      width: 2.5,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Icon(feature.icon, size: 18, color: AppColors.onInk),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  // Always two lines tall so every chip matches.
                  height: textScaler.scale(_labelSize) * _labelHeight * 2 + 1,
                  child: Text(
                    feature.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: _labelSize,
                      height: _labelHeight,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary.withValues(alpha: 0.85),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
