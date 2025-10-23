import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String? errorText;

  const ErrorMessage({
    super.key,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    if (errorText == null || errorText!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 0, 0, 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color.fromRGBO(255, 0, 0, 0.1),
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}