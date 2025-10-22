import 'package:flutter/material.dart';
import 'package:multipurpose_app/coins/utils/obtener_vuelto.dart';

class VueltoPage extends StatefulWidget {
  @override
  State<VueltoPage> createState() => _VueltoPageState();
}

class _VueltoPageState extends State<VueltoPage> {
  // declarar controladores
  final precioCtrl = TextEditingController();
  final montoCtrl = TextEditingController();

  // declarar varaibles
  var monedas_vuelto = [0,0,0,0,0];
  double resto = 0;
  String msgError = "";

  // metodo para calcular el vuelto
  void calcularVuelto() {
    // convertir los textos ingresados
    final precio = double.tryParse(precioCtrl.text) ?? 0;
    final monto = double.tryParse(montoCtrl.text) ?? 0;

    // establecer valores por defecto a variables
    monedas_vuelto.fillRange(0, monedas_vuelto.length, 0);
    msgError = "";

    setState(() {
      // parar si hay valores negativos
      if(monto < 0 || precio < 0) {
        msgError = "¡No pueden haber valores negativos!";
        return;
      }

      // parar si el monto dado es menor al precio
      if(monto < precio) {
        msgError = "¡El monto ingresado es menor al precio del producto!";
        return;
      }

      // llamar a la función con el algoritmo
      final (monVuel, res) = obtenerMonedas(precio, monto);
      monedas_vuelto = monVuel;
      resto = res;

      // caso especial, si no se pudo dar todo el vuelto
      if(res != 0) {
        msgError = "Faltan por dar \$${res}";
      }
    });
  }


  //Diseño
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vuelto Mínimo"),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Ingrese el precio del producto y el monto a pagar",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 12,),

              TextField(
                controller: precioCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "precio (2 decimales)",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 12,),

              TextField(
                controller: montoCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "monto (2 decimales)",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 12,),

              ElevatedButton(
                  onPressed: calcularVuelto,
                  child: Text("Calcular")
              ),

              ErrorMessage(errorText: msgError),

              SizedBox(height: 18,),

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
          ),
        ),
      ),
    );
  }
}


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