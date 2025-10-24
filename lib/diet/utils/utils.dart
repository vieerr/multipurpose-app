import 'package:flutter/material.dart';
class Utils {

  static Color colorForState(String? state) {
    switch (state?.toUpperCase()) {
      case 'SUBIO':
        return Colors.red;
      case 'BAJO':
        return Colors.green;
      case 'IGUAL':
        return Colors.orange;
      default:
        return Colors.blueGrey;
    }
  }

  static Color colorForDifference(double? difference) {
    if (difference == null) return Colors.grey;
    if (difference > 0) return Colors.red;
    if (difference < 0) return Colors.green;
    return Colors.orange;
  }

  static String labelForDifference(double? difference) {
    if (difference == null) return 'Sin datos';
    if (difference > 0) return 'SUBIÓ ${difference.abs().toStringAsFixed(2)} kg';
    if (difference < 0) return 'BAJÓ ${difference.abs().toStringAsFixed(2)} kg';
    return 'IGUAL';
  }

}
