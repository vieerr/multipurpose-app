const monedas = [200,100,50,25,10];

(List<int>, double) obtenerMonedas(double precio, double monto) {
  int cambio = ((monto - precio) * 100).round();

  var monedasVuelto = [0,0,0,0,0];
  int resto = cambio;

  int i = 0;
  while(i<5) {
    if(resto == 0){
      break;
    }

    if((resto - monedas[i]) < 0) {
      i++;
      continue;
    }

    resto -= monedas[i];
    monedasVuelto[i]++;
  }

  return (monedasVuelto, resto/100);
}