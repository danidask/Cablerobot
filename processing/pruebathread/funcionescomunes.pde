int[] generararrayretardos(int valor, int valormaximo) {
  int[] Aretardos = new int[maximonumeropasos];
  int valormedio = 0 ;
  float resto = 0 ; //tiene que ser float para hacer bien la division
  int total = 0;
  int intervalo = 0;
  if (valor > 0) {
    valormedio = floor(valormaximo / valor);
    resto = valormaximo % valor;
    for (int i = 0; i < valor; i++) {
      Aretardos[i] = valormedio;
    }
    while (total != valormaximo) {
      if (resto > 0) {
        intervalo = ceil(valor / resto);
        for (int i = 0; i < valor; i+=intervalo) {
          Aretardos[i]++;
        }
      }
      total = 0;
      for (int i = 0; i < valor; i++) {
        total += Aretardos[i];
      }
      resto = valormaximo - total;
    }
  }
  return Aretardos;
}

int sacarmayor(int valores[]) {
  int mayor = 0;
  int indicemayor = 0;
  for (int i = 0; i < valores.length; i++) {
    if (valores[i] > mayor) {
      mayor = valores[i] ;
      indicemayor = i;
    }
  }
  return indicemayor;
}