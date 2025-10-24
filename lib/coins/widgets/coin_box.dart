import 'package:flutter/material.dart';

import 'coin_display.dart';

class CoinBox extends StatelessWidget {
  final List<int> monedas_vuelto;

  const CoinBox({super.key, required this.monedas_vuelto});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            "Cantidad de monedas a dar",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(height: 24,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CoinDisplay(coinValue: "\$2.00", value: monedas_vuelto[0]),
            CoinDisplay(coinValue: "\$1.00", value: monedas_vuelto[1]),
          ],
        ),

        SizedBox(height: 24,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CoinDisplay(coinValue: "\$0.50", value: monedas_vuelto[2]),
            CoinDisplay(coinValue: "\$0.25", value: monedas_vuelto[3]),
          ],
        ),

        SizedBox(height: 24,),

        Center(
          child: CoinDisplay(coinValue: "\$0.10", value: monedas_vuelto[4]),
        ),
      ],
    );
  }
}
