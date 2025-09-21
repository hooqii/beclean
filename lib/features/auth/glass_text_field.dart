import 'dart:ui';

import 'package:flutter/material.dart';

class GlassTextField extends StatefulWidget {
  const GlassTextField({
    super.key,
    this.keyboardType,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool isPassword;

  @override
  State<GlassTextField> createState() => _GlassTextFieldState();
}

class _GlassTextFieldState extends State<GlassTextField> {
  bool _show = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          color: Colors.white24,
          child: TextField(
            controller: widget.controller,
            obscureText: widget.isPassword && !_show,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Colors.white),
              prefixIcon: Icon(widget.icon, color: Colors.white),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _show ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() => _show = !_show);
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
            ),
            keyboardType: widget.keyboardType,
          ),
        ),
      ),
    );
  }
}
