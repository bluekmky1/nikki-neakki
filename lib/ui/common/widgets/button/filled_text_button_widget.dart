import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';

class FilledTextButtonWidget extends StatefulWidget {
  const FilledTextButtonWidget({
    required this.title,
    required this.onPressed,
    super.key,
  });

  final String title;
  final VoidCallback? onPressed;

  @override
  State<FilledTextButtonWidget> createState() => _FilledTextButtonWidgetState();
}

class _FilledTextButtonWidgetState extends State<FilledTextButtonWidget> {
  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          backgroundColor:
              widget.onPressed == null ? AppColors.gray400 : AppColors.main,
          foregroundColor:
              widget.onPressed == null ? AppColors.gray600 : AppColors.white,
          textStyle: AppTextStyles.textSb18.copyWith(
            color:
                widget.onPressed == null ? AppColors.gray600 : AppColors.white,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.title),
          ],
        ),
      );
}
