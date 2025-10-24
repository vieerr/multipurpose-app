class AnioModel {
  //Condicion si es bisiesto
  static bool esBisiesto(int anio){
    if (anio % 4 != 0){
      return false;
    } else if (anio % 100 != 0){
      return true;
    } else if (anio % 400 == 0){
      return true;
    } else {
      return false;
    }
  }
}