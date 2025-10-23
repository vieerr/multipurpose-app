import '../model/vuelto_model.dart';

class VueltoController{
  (List<int>, String) calcularCambio(String precioProd, String montoUsr) {
    // verificar que los campos estén llenados
    if(precioProd.isEmpty || montoUsr.isEmpty) {
      return (List.filled(5, 0), "Llene todos los campos para continuar");
    }

    final precio = double.tryParse(precioProd);
    final monto = double.tryParse(montoUsr);

    // verificar que sean valores double
    if(precio == null || monto == null) {
      return (List.filled(5, 0), "Ingrese un valor numérico");
    }

    // verificar que no hayan valores negativos
    if(monto < 0 || precio < 0) {
      return (List.filled(5, 0), "¡No pueden haber valores negativos!");
    }

    // verificar que el monto sea mayor que el precio
    if(monto < precio) {
      return(List.filled(5, 0), "¡El monto ingresado es menor al precio del producto!");
    }

    // si no hay errores en el ingreso a datos calular el vuelto con el Model
    final vuelto = VueltoModel(precio, monto);
    final (monedas, resto) = vuelto.obtenerMonedas();

    // caso especial, si no se pudo dar todo el vuelto
    if(resto != 0) {
      return (monedas,"Faltan por dar \$${resto}" );
    }

    // si se pudo dar todo el vuelto, regresar sin mensaje de error
    return (monedas, "");
  }
}