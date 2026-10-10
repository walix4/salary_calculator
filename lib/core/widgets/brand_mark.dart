import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Pink pill wordmark, in the spirit of the Klarna logo badge.
class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.label = 'Salary', this.fontSize = 22});

  final String label;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      child: ExcludeSemantics(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: fontSize * 0.55,
            vertical: fontSize * 0.22,
          ),
          decoration: BoxDecoration(
            color: AppColors.pink,
            borderRadius: BorderRadius.circular(fontSize * 0.45),
          ),
          child: Text(
            label,
            textScaler: TextScaler.noScaling,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              letterSpacing: -fontSize * 0.03,
              color: AppColors.ink,
            ),
          ),
        ),
      ),
    );
  }
}

/// Full-screen brand splash shown while startup state loads.
class BrandSplash extends StatelessWidget {
  const BrandSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: BrandMark(fontSize: 40)),
    );
  }
}
