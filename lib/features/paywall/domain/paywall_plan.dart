/// Billing period of a subscription plan.
enum PlanPeriod { weekly, monthly, yearly }

/// Store-agnostic subscription plan shown on the paywall.
class PaywallPlan {
  const PaywallPlan({
    required this.id,
    required this.period,
    required this.price,
    this.trialDays,
  });

  final String id;
  final PlanPeriod period;

  /// Price in PKR per [period].
  final double price;

  /// Free-trial length, if the plan has one.
  final int? trialDays;

  String get label => switch (period) {
    PlanPeriod.weekly => '1 WEEK',
    PlanPeriod.monthly => '1 MONTH',
    PlanPeriod.yearly => '1 YEAR',
  };

  String get unitName => switch (period) {
    PlanPeriod.weekly => 'week',
    PlanPeriod.monthly => 'month',
    PlanPeriod.yearly => 'year',
  };

  /// What this plan works out to per week, for comparing plans.
  double get pricePerWeek => switch (period) {
    PlanPeriod.weekly => price,
    PlanPeriod.monthly => price * 12 / 52,
    PlanPeriod.yearly => price / 52,
  };
}

/// PLACEHOLDER plans for the UI-only paywall. Billing is not wired yet: when
/// a store/RevenueCat integration is added, load real products and localized
/// prices instead of these sample values.
const List<PaywallPlan> samplePaywallPlans = [
  PaywallPlan(id: 'premium_weekly', period: PlanPeriod.weekly, price: 450),
  PaywallPlan(
    id: 'premium_monthly',
    period: PlanPeriod.monthly,
    price: 1100,
    trialDays: 3,
  ),
  PaywallPlan(id: 'premium_yearly', period: PlanPeriod.yearly, price: 6500),
];

/// Plan highlighted with the "Popular" badge and selected by default.
const String popularPlanId = 'premium_monthly';
