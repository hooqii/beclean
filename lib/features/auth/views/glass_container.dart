import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0),
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(color: Colors.white24, width: 1.5),
          ),
          child: child,
        ),
      ),
    );
  }
}
