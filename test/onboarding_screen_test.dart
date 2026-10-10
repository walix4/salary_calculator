import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salary_calculator/core/theme/app_theme.dart';
import 'package:salary_calculator/features/onboarding/data/onboarding_storage.dart';
import 'package:salary_calculator/features/onboarding/presentation/onboarding_controller.dart';
import 'package:salary_calculator/features/onboarding/presentation/screens/onboarding_screen.dart';

class _FakeOnboardingStorage extends OnboardingStorage {
  _FakeOnboardingStorage();

  bool completed = false;

  @override
  Future<bool> isCompleted() async => completed;

  @override
  Future<void> setCompleted(bool value) async => completed = value;
}

void main() {
  testWidgets('Continue twice then Get started completes onboarding', (
    tester,
  ) async {
    final storage = _FakeOnboardingStorage();
    final container = ProviderContainer(
      overrides: [onboardingStorageProvider.overrideWithValue(storage)],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light,
          home: const OnboardingScreen(),
        ),
      ),
    );
    expect(await container.read(onboardingControllerProvider.future), isFalse);

    expect(find.text('Salary maths, made simple'), findsOneWidget);
    expect(find.bySemanticsLabel('Page 1 of 3'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('See every rupee'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Private by design'), findsOneWidget);
    expect(find.text('Continue'), findsNothing);

    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    expect(container.read(onboardingControllerProvider).value, isTrue);
    expect(storage.completed, isTrue);
  });

  testWidgets('Skip completes onboarding', (tester) async {
    final storage = _FakeOnboardingStorage();
    final container = ProviderContainer(
      overrides: [onboardingStorageProvider.overrideWithValue(storage)],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light,
          home: const OnboardingScreen(),
        ),
      ),
    );
    await tester.tap(find.byTooltip('Skip'));
    await tester.pumpAndSettle();

    expect(container.read(onboardingControllerProvider).value, isTrue);
  });

  testWidgets('Small screen with large text renders without overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          onboardingStorageProvider.overrideWithValue(_FakeOnboardingStorage()),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(1.6)),
            child: child!,
          ),
          home: const OnboardingScreen(),
        ),
      ),
    );
    for (var i = 0; i < 2; i++) {
      expect(tester.takeException(), isNull);
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
    }
    expect(tester.takeException(), isNull);
  });
}
