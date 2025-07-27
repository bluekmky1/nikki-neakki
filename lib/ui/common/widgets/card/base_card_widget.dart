import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class BaseCardWidget extends StatelessWidget {
  const BaseCardWidget({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 16.0,
    this.backgroundColor = AppColors.white,
    this.borderColor = AppColors.gray200,
    this.shadowColor = AppColors.gray200,
    this.shadowBlurRadius = 10.0,
    this.shadowOffset = const Offset(0, 4),
    this.hasShadow = true,
    super.key,
  });

  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final Color backgroundColor;
  final Color borderColor;
  final Color shadowColor;
  final double shadowBlurRadius;
  final Offset shadowOffset;
  final bool hasShadow;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor),
          boxShadow: hasShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: shadowBlurRadius,
                    offset: shadowOffset,
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      );
}
