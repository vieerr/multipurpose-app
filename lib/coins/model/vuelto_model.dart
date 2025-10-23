const MONEDAS = [200,100,50,25,10];

class VueltoModel {

  final double precio;
  final double monto;

  VueltoModel(this.precio, this.monto);

  (List<int>, double) obtenerMonedas() {
    int cambio = ((monto - precio) * 100).round();

    var monedasVuelto = [0,0,0,0,0];
    int resto = cambio;

    int i = 0;
    while(i<5) {
      if(resto == 0){
        break;
      }

      if((resto - MONEDAS[i]) < 0) {
        i++;
        continue;
      }

      resto -= MONEDAS[i];
      monedasVuelto[i]++;
    }

    return (monedasVuelto, resto/100);
  }
}