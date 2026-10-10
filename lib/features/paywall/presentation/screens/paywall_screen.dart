import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/paywall_plan.dart';
import '../premium_controller.dart';
import '../widgets/paywall_feature_strip.dart';
import '../widgets/paywall_hero.dart';
import '../widgets/paywall_plan_tile.dart';

/// Premium paywall. [onClose] continues on the free tier.
///
/// UI only: billing is not wired yet, so the purchase and restore actions say
/// so honestly instead of pretending to buy anything.
class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key, required this.onClose, this.source = ''});

  final VoidCallback onClose;

  /// Where the paywall was opened from (e.g. 'onboarding', 'record_limit').
  final String source;

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  /// The hero never gets shorter than this; below it the page scrolls.
  static const double _minHeroHeight = 200;

  /// How far the offer sheet rides up over the hero.
  static const double _sheetOverlap = 28;

  /// Display order: longest commitment first, popular plan in the middle.
  static final List<PaywallPlan> _plans = [
    for (final period in PlanPeriod.values.reversed)
      samplePaywallPlans.firstWhere((plan) => plan.period == period),
  ];

  String _selectedId = popularPlanId;

  PaywallPlan get _selected =>
      _plans.firstWhere((plan) => plan.id == _selectedId);

  String get _termsLine {
    final plan = _selected;
    final price = '${formatPaywallPrice(plan.price)}/${plan.unitName}';
    final trialDays = plan.trialDays;
    if (trialDays != null) {
      return '$trialDays-day free trial, then $price. Renews automatically '
          'until cancelled. Cancel anytime in Settings at least 24 hours '
          'before the trial ends.';
    }
    return '$price. Renews automatically until cancelled. '
        'Cancel anytime in Settings.';
  }

  void _purchase() {
    // TODO(billing): start the store purchase for [_selected] (and its trial)
    // via StoreKit / Play Billing / RevenueCat, then flip isPremiumProvider.
    showAppToast(
      context,
      "Purchases aren't available yet.",
      type: AppToastType.info,
    );
  }

  void _restore() {
    // TODO(billing): restore previous purchases from the store.
    showAppToast(
      context,
      "Purchases aren't available yet.",
      type: AppToastType.info,
    );
  }

  void _comingSoon() =>
      showAppToast(context, 'Coming soon', type: AppToastType.info);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(child: _hero(padding.top)),
                        _sheet(padding.bottom),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: padding.top + AppSpacing.xs,
              left: AppSpacing.screen - 2,
              child: _CloseButton(onPressed: widget.onClose),
            ),
          ],
        ),
      ),
    );
  }

  /// Hero fills the height left over by the sheet, and extends under it by
  /// [_sheetOverlap] so the sheet's rounded corners sit on the artwork.
  Widget _hero(double topPadding) {
    // Clear the status bar and the close button.
    final topInset = topPadding + 52;
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: _minHeroHeight + topPadding),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: -_sheetOverlap,
            child: PaywallHero(
              topInset: topInset,
              bottomInset: _sheetOverlap + AppSpacing.sm,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sheet(double bottomPadding) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    const sidePadding = AppSpacing.screenPadding;
    final footerStyle = TextStyle(
      fontSize: 11,
      height: 1.3,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary,
    );

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadii.xl)),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: AppSpacing.lg, bottom: bottomPadding),
        child: ContentConstraint(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: sidePadding,
                child: Semantics(
                  header: true,
                  child: const Text(
                    'Unlock Premium',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      height: 1.2,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxs + 2),
              Padding(
                padding: sidePadding,
                child: Text(
                  'Save unlimited salary records instead of $freeRecordLimit. '
                  'The calculator stays free.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.35,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              const PaywallFeatureStrip(),
              const SizedBox(height: AppSpacing.lg),
              Padding(
                padding: sidePadding,
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final (index, plan) in _plans.indexed) ...[
                        if (index > 0) const SizedBox(width: 10),
                        Expanded(
                          child: PaywallPlanTile(
                            plan: plan,
                            isSelected: plan.id == _selectedId,
                            isPopular: plan.id == popularPlanId,
                            onTap: () {
                              if (plan.id == _selectedId) return;
                              HapticFeedback.selectionClick();
                              setState(() => _selectedId = plan.id);
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg - 4),
              Padding(
                padding: sidePadding,
                child: AppButton(
                  label: _selected.trialDays != null
                      ? 'Start free trial'
                      : 'Continue',
                  onPressed: _purchase,
                ),
              ),
              const SizedBox(height: AppSpacing.sm - 1),
              Padding(
                padding: sidePadding,
                child: AnimatedSwitcher(
                  duration: reduceMotion
                      ? Duration.zero
                      : const Duration(milliseconds: 200),
                  child: Text(
                    _termsLine,
                    key: ValueKey(_selectedId),
                    textAlign: TextAlign.center,
                    style: footerStyle,
                  ),
                ),
              ),
              Padding(
                padding: sidePadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _FooterLink('Privacy Policy', footerStyle, _comingSoon),
                    const _Dot(),
                    _FooterLink('Restore purchase', footerStyle, _restore),
                    const _Dot(),
                    _FooterLink('Terms of Use', footerStyle, _comingSoon),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      shape: const CircleBorder(),
      elevation: 0,
      shadowColor: AppColors.ink,
      child: IconButton(
        tooltip: 'Close',
        onPressed: onPressed,
        constraints: const BoxConstraints.tightFor(width: 40, height: 40),
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.close, size: 20, color: AppColors.ink),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink(this.label, this.style, this.onTap);

  final String label;
  final TextStyle style;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Semantics(
        button: true,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadii.smAll,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 44),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Center(
                widthFactor: 1,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(label, maxLines: 1, style: style),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: SizedBox.square(
        dimension: 3,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.textTertiary,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
