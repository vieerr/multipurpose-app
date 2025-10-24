import '../model/anios_model.dart';

class AnioController {
  static const int maxAnio = 9999;

  String procesar(String anioStr) {
    if (anioStr.isEmpty) {
      return 'Ingrese un año';
    }

    final anio = int.tryParse(anioStr);
    if (anio == null || anio <= 0) {
      return 'Ingrese un número válido';
    }

    if (anio > maxAnio) {
      return 'Ingrese un año menor o igual a $maxAnio';
    }

    final esBisiesto = AnioModel.esBisiesto(anio);
    if (esBisiesto) {
      return 'El año $anio es bisiesto';
    } else {
      return 'El año $anio no es bisiesto';
    }
  }
}
