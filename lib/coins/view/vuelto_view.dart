import 'package:flutter/material.dart';

import '../controller/vuelto_controller.dart';
import '../widgets/input_vuelto.dart';
import '../widgets/error_message.dart';
import '../widgets/coin_box.dart';

class VueltoPage extends StatefulWidget {
  @override
  State<VueltoPage> createState() => _VueltoPageState();
}

class _VueltoPageState extends State<VueltoPage> {
  // declarar controladores
  final precioCtrl = TextEditingController();
  final montoCtrl = TextEditingController();
  final vueltoCtrl = VueltoController();

  // declarar variables
  var monedas_vuelto = [0,0,0,0,0];
  String msgError = "";

  // metodo para calcular el vuelto
  void _calcularVuelto() {

    // Obtener valores usando el controllador
    final (monVuel, err) = vueltoCtrl.calcularCambio(precioCtrl.text, montoCtrl.text);

    // actualizar el estado según los valores
    setState(() {
      monedas_vuelto = monVuel;
      msgError = err;
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

              InputVuelto(ctrl: precioCtrl, label: "precio (2 decimales)"),

              SizedBox(height: 12,),

              InputVuelto(ctrl: montoCtrl, label: "monto (2 decimales)"),

              SizedBox(height: 12,),

              ElevatedButton(
                  onPressed: _calcularVuelto,
                  child: Text("Calcular")
              ),

              ErrorMessage(errorText: msgError),

              SizedBox(height: 18,),

              CoinBox(monedas_vuelto: monedas_vuelto),
            ],
          ),
        ),
      ),
    );
  }
}