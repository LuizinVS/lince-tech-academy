double converterParaFahrenheit(double celsius) {
  return celsius * 9 / 5 + 32;
}

double converterParaKelvin(double celsius) {
  return celsius + 273.15;
}

void main() {
  final temperaturas = [0.0, 4.2, 15.0, 18.1, 21.7, 32.0, 40.0, 41.0];

  for (final celsius in temperaturas) {
    final fahrenheit = converterParaFahrenheit(celsius).toStringAsFixed(2);
    final kelvin = converterParaKelvin(celsius).toStringAsFixed(2);
    print(
        'Celcius: ${celsius.toStringAsFixed(2)}, fahrenheit: $fahrenheit, kelvin: $kelvin');
  }
}