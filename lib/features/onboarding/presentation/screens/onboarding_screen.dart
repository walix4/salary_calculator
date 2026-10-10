import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../onboarding_controller.dart';
import '../widgets/onboarding_illustrations.dart';

/// Three-page intro. Finishing or skipping calls
/// [OnboardingController.complete]; the app gate then swaps in the main shell.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  static const _pageDuration = Duration(milliseconds: 320);

  final _controller = PageController();
  int _page = 0;
  bool _completing = false;

  static const List<_PageData> _pages = [
    _PageData(
      header: BrandMark(fontSize: 24),
      title: 'Salary maths, made simple',
      rows: [
        _RowData(
          icon: Icons.calculate_outlined,
          text: 'Calculate net pay from your basic salary and days served.',
        ),
        _RowData(
          icon: Icons.receipt_long_outlined,
          text: 'PF, EOBI and tax deductions are handled for you.',
        ),
        _RowData(
          icon: Icons.bookmark_border,
          text: 'Save records to revisit them later.',
        ),
      ],
    ),
    _PageData(
      header: BreakdownIllustration(),
      title: 'See every rupee',
      description:
          'Every figure that goes into your salary, laid out clearly as you '
          'enter it.',
      rows: [
        _RowData(
          icon: Icons.bolt_outlined,
          title: 'Live preview',
          text: 'Results update as you type',
        ),
        _RowData(
          icon: Icons.list_alt_outlined,
          title: 'Clear breakdown',
          text: 'Prorated salary and each deduction, line by line',
        ),
        _RowData(
          icon: Icons.account_balance_wallet_outlined,
          title: 'Net payable at a glance',
          text: 'The amount that matters, front and centre',
        ),
      ],
    ),
    _PageData(
      header: PrivacyIllustration(),
      title: 'Private by design',
      description: 'Your salary details are yours alone.',
      rows: [
        _RowData(
          icon: Icons.phone_iphone,
          title: 'Stays on this device',
          text: 'Records are stored locally, never uploaded',
        ),
        _RowData(
          icon: Icons.person_off_outlined,
          title: 'No account needed',
          text: 'No sign-up, no login, just start calculating',
        ),
        _RowData(
          icon: Icons.edit_outlined,
          title: 'Edit or delete anytime',
          text: 'You stay in control of every saved record',
        ),
      ],
    ),
  ];

  bool get _isLast => _page == _pages.length - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _complete() async {
    if (_completing) return;
    setState(() => _completing = true);
    try {
      await ref.read(onboardingControllerProvider.notifier).complete();
    } finally {
      if (mounted) setState(() => _completing = false);
    }
  }

  void _next() {
    if (_isLast) {
      _complete();
      return;
    }
    _controller.nextPage(duration: _pageDuration, curve: Curves.easeOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ContentConstraint(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: AppSpacing.xxs,
                ),
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: IconButton(
                    tooltip: 'Skip',
                    icon: const Icon(Icons.close),
                    onPressed: _completing ? null : _complete,
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (i) => setState(() => _page = i),
                  itemBuilder: (context, i) => _OnboardingPage(data: _pages[i]),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _PageDots(count: _pages.length, index: _page),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screen,
                  AppSpacing.lg,
                  AppSpacing.screen,
                  AppSpacing.md,
                ),
                child: AppButton(
                  label: _isLast ? 'Get started' : 'Continue',
                  isLoading: _completing,
                  onPressed: _next,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageData {
  const _PageData({
    required this.header,
    required this.title,
    required this.rows,
    this.description,
  });

  final Widget header;
  final String title;
  final String? description;
  final List<_RowData> rows;
}

class _RowData {
  const _RowData({required this.icon, required this.text, this.title});

  final IconData icon;
  final String? title;
  final String text;
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.data});

  final _PageData data;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screen + AppSpacing.xs,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpacing.md),
              Center(child: data.header),
              const SizedBox(height: AppSpacing.xl),
              Semantics(
                header: true,
                child: Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: AppTypography.pageTitle,
                ),
              ),
              if (data.description != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  data.description!,
                  textAlign: TextAlign.center,
                  style: AppTypography.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.xl),
              for (final row in data.rows) _FeatureRow(data: row),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.data});

  final _RowData data;

  @override
  Widget build(BuildContext context) {
    final hasTitle = data.title != null;
    return MergeSemantics(
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xxs / 2),
              child: Icon(
                data.icon,
                size: AppSpacing.iconSize + AppSpacing.xxs,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hasTitle) ...[
                    Text(data.title!, style: AppTypography.cardTitle),
                    const SizedBox(height: AppSpacing.xxs / 2),
                  ],
                  Text(
                    data.text,
                    style: hasTitle
                        ? AppTypography.bodySecondary
                        : AppTypography.body.copyWith(
                            color: AppColors.textSecondary,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.index});

  final int count;
  final int index;

  static const double _dot = AppSpacing.xs;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Page ${index + 1} of $count',
      liveRegion: true,
      child: ExcludeSemantics(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < count; i++)
              AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeOutCubic,
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
                width: i == index ? _dot * 3 : _dot,
                height: _dot,
                decoration: BoxDecoration(
                  color: i == index ? AppColors.ink : AppColors.borderStrong,
                  borderRadius: AppRadii.pillAll,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
