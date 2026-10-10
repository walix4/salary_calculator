import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:salary_calculator/core/theme/app_theme.dart';
import 'package:salary_calculator/core/widgets/widgets.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: AppTheme.light,
  home: Scaffold(body: child),
);

void main() {
  testWidgets('AppButton fires onPressed and blocks taps while loading', (
    tester,
  ) async {
    var taps = 0;
    await tester.pumpWidget(
      _wrap(AppButton(label: 'Save', onPressed: () => taps++)),
    );
    await tester.tap(find.text('Save'));
    expect(taps, 1);

    await tester.pumpWidget(
      _wrap(AppButton(label: 'Save', isLoading: true, onPressed: () => taps++)),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.tap(find.byType(FilledButton));
    expect(taps, 1);
  });

  testWidgets('showConfirmSheet resolves true on confirm, false on cancel', (
    tester,
  ) async {
    bool? result;
    await tester.pumpWidget(
      _wrap(
        Builder(
          builder: (context) => TextButton(
            onPressed: () async => result = await showConfirmSheet(
              context,
              title: 'Delete record?',
              message: 'Gone forever.',
              confirmLabel: 'Yes, delete',
            ),
            child: const Text('open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Yes, delete'));
    await tester.pumpAndSettle();
    expect(result, isTrue);

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(result, isFalse);
  });

  testWidgets('EmptyStateView shows CTA and triggers action', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      _wrap(
        EmptyStateView(
          title: 'No records',
          message: 'Add one',
          actionLabel: 'Add salary',
          onAction: () => tapped = true,
        ),
      ),
    );
    await tester.tap(find.text('Add salary'));
    expect(tapped, isTrue);
  });

  testWidgets('AppTextField runs validator on input', (tester) async {
    await tester.pumpWidget(
      _wrap(
        AppTextField(
          label: 'Amount',
          validator: (v) => (v ?? '').isEmpty ? 'Required' : null,
        ),
      ),
    );
    await tester.enterText(find.byType(TextFormField), 'x');
    await tester.enterText(find.byType(TextFormField), '');
    await tester.pump();
    expect(find.text('Required'), findsOneWidget);
  });
}
