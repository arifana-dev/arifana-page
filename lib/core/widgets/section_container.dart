import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';
import '../utils/responsive.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    required this.child,
    this.background,
    this.topPadding,
    this.bottomPadding,
    this.maxWidth = AppSpacing.maxContentWidth,
    super.key,
  });

  final Widget child;
  final Color? background;
  final double? topPadding;
  final double? bottomPadding;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final hPad = Responsive.value<double>(
      context,
      mobile: AppSpacing.mobileHPad,
      tablet: AppSpacing.tabletHPad,
      desktop: AppSpacing.desktopHPad,
    );
    final vPad = Responsive.value<double>(
      context,
      mobile: AppSpacing.xxl,
      tablet: AppSpacing.xxxl,
      desktop: AppSpacing.section,
    );

    return Container(
      width: double.infinity,
      color: background,
      padding: EdgeInsets.fromLTRB(
        hPad,
        topPadding ?? vPad,
        hPad,
        bottomPadding ?? vPad,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}
