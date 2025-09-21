import 'dart:ui';

import 'package:beclean/core/config/app_colors.dart';
import 'package:flutter/material.dart';

class GlassButton extends StatelessWidget {
  const GlassButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.loading = false,
  });

  final void Function() onPressed;
  final String text;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: loading
                  ? AppColors.primary.withAlpha(125)
                  : AppColors.primary,
              foregroundColor: Colors.white,
              shape: const RoundedRectangleBorder(side: BorderSide.none),
              shadowColor: Colors.transparent,
            ),
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
