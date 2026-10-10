import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salary_calculator/core/theme/app_theme.dart';
import 'package:salary_calculator/features/paywall/presentation/screens/paywall_screen.dart';

Widget _app({
  required VoidCallback onClose,
  TextScaler textScaler = TextScaler.noScaling,
}) {
  return MaterialApp(
    theme: AppTheme.light,
    // The hero floats and the feature strip drifts forever; disabling
    // animations keeps pumpAndSettle from waiting on them.
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(disableAnimations: true, textScaler: textScaler),
      child: child!,
    ),
    home: PaywallScreen(onClose: onClose, source: 'test'),
  );
}

void _setPhoneSize(WidgetTester tester, Size size) {
  tester.view
    ..devicePixelRatio = 1
    ..physicalSize = size;
  addTearDown(tester.view.reset);
}

void main() {
  testWidgets('shows plans, switches CTA and is honest about billing', (
    tester,
  ) async {
    _setPhoneSize(tester, const Size(390, 844));
    var closed = 0;
    await tester.pumpWidget(_app(onClose: () => closed++));
    await tester.pumpAndSettle();

    expect(find.text('Unlock Premium'), findsOneWidget);
    expect(find.text('Rs 450'), findsOneWidget);
    expect(find.text('Rs 1,100'), findsOneWidget);
    expect(find.text('Rs 6,500'), findsOneWidget);
    expect(find.text('POPULAR'), findsOneWidget);

    // Monthly (popular, with trial) is selected by default.
    expect(find.text('Start free trial'), findsOneWidget);
    expect(find.textContaining('3-day free trial'), findsOneWidget);

    await tester.tap(find.text('Rs 450'));
    await tester.pumpAndSettle();
    expect(find.text('Start free trial'), findsNothing);
    expect(find.text('Continue'), findsOneWidget);
    expect(find.textContaining('Rs 450/week. Renews'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text("Purchases aren't available yet."), findsOneWidget);

    await tester.tap(find.byTooltip('Close'));
    await tester.pump();
    expect(closed, 1);
  });

  testWidgets('fits a small phone with large text without overflow', (
    tester,
  ) async {
    _setPhoneSize(tester, const Size(320, 568));
    var closed = 0;
    await tester.pumpWidget(
      _app(onClose: () => closed++, textScaler: const TextScaler.linear(1.5)),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    // The page scrolls so the purchase button is still reachable.
    final cta = find.text('Start free trial');
    await tester.ensureVisible(cta);
    await tester.pumpAndSettle();
    await tester.tap(cta);
    await tester.pumpAndSettle();
    expect(find.text("Purchases aren't available yet."), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
