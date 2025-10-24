import 'package:flutter/material.dart';

class CoinDisplay extends StatelessWidget {
  final String coinValue;
  final int value;

  CoinDisplay({
    super.key,
    required this.coinValue,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Contenedor en forma de círculo
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 3,
            ),
          ),
          child: Center(
            child: Text(
              coinValue,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(width: 16),

        // Valor de las monedas a dar
        Text(
          "$value",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: value !=0 ? Colors.amber[800] : Colors.black,
          ),
        ),
      ],
    );
  }
}