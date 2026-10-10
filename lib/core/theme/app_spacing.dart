import 'package:flutter/widgets.dart';

/// 4pt spacing scale.
class AppSpacing {
  AppSpacing._();

  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  /// Horizontal screen margin.
  static const double screen = 16;
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: screen,
  );

  static const double buttonHeight = 52;
  static const double inputHeight = 56;
  static const double iconSize = 20;
  static const double iconContainer = 40;

  /// Max content width so layouts stay readable on tablets.
  static const double maxContentWidth = 600;
}

/// Corner radius tokens.
class AppRadii {
  AppRadii._();

  static const double sm = 8;
  static const double md = 12;
  static const double lg = 20;
  static const double xl = 28;
  static const double pill = 999;

  static const BorderRadius smAll = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdAll = BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgAll = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius xlAll = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius pillAll = BorderRadius.all(Radius.circular(pill));
}
