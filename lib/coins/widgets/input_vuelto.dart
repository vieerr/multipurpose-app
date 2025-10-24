import 'package:flutter/material.dart';

class InputVuelto extends StatelessWidget {
  final TextEditingController ctrl;
  final String label;

  InputVuelto({
    super.key,
    required this.ctrl,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ctrl,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}