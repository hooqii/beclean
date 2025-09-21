import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.error});
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Text(
      error ?? "",
      style: TextStyle(color: Colors.red),
    );
  }
}
