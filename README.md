# Salary Calculator

A Flutter mobile app for calculating and managing employee salary records with PF, EOBI, and tax deductions. Built with **clean architecture**, **Riverpod** (code generation), and **Drift/SQLite** for local persistence.

## Features

- Full CRUD on salary records (create, list, edit, delete)
- Live net salary preview while filling the form
- Detailed salary breakdown (gross, prorated, PF, EOBI, tax, net)
- Swipe-to-delete with confirmation
- Pull-to-refresh on the list screen
- PKR currency formatting via `intl`

## Architecture

```
lib/
├── core/                          # Shared constants, errors, utils
├── features/salary_calculator/
│   ├── data/                      # Drift DB, models, repository impl
│   ├── domain/                    # Entities, use cases, repo contracts
│   └── presentation/              # Screens, widgets, Riverpod providers
└── main.dart
```

**Layers:**
- **Presentation** — Material 3 UI, Riverpod `AsyncNotifier` / stream providers
- **Domain** — Pure Dart entities, use cases (including salary calculation)
- **Data** — Drift SQLite database, mappers, repository implementation

## Prerequisites

- Flutter SDK 3.11+
- Dart 3.11+

## Setup

1. Install dependencies:

```bash
flutter pub get
```

2. **Run code generation** (required before first run):

```bash
dart run build_runner build --delete-conflicting-outputs
```

This generates:
- Drift database code (`app_database.g.dart`)
- Freezed entity/state classes (`*.freezed.dart`)
- Riverpod providers (`*.g.dart`)

3. Run the app:

```bash
flutter run
```

## Running Tests

```bash
flutter test
```

Unit tests cover the `CalculateSalaryUseCase` including edge cases (0 days served, full month, clamping, etc.).

## Salary Calculation

| Field | Formula |
|-------|---------|
| Prorated salary | `(basicSalary / numberOfDaysInMonth) × numberOfDaysServed` |
| PF deduction | `proratedSalary × (pfPercentage / 100)` |
| Total deductions | `pfDeduction + eobiAmount + taxAmount` |
| Net salary | `proratedSalary - totalDeductions` |

Default PF percentage: **7.5%** (editable per record).

## Regenerating Code

After changing Drift tables, Freezed models, or Riverpod annotations:

```bash
dart run build_runner build --delete-conflicting-outputs
```

For watch mode during development:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

## Key Packages

| Package | Purpose |
|---------|---------|
| `flutter_riverpod` + `riverpod_generator` | State management |
| `drift` + `sqlite3_flutter_libs` | Local SQLite persistence |
| `freezed` | Immutable domain entities |
| `intl` | PKR currency formatting |
