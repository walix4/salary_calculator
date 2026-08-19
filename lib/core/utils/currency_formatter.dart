import 'package:intl/intl.dart';

import '../constants/app_constants.dart';

/// Formats monetary values as Pakistani Rupees (PKR).
class CurrencyFormatter {
  CurrencyFormatter._();

  static final NumberFormat _format = NumberFormat.currency(
    locale: AppConstants.currencyLocale,
    symbol: 'PKR ',
    decimalDigits: 2,
  );

  static String format(double amount) => _format.format(amount);
}
