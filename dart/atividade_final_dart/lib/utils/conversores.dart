import 'dart:math' as math;

class Conversores {
	Conversores._();

	static double celsiusParaFahrenheit(double celsius) {
		return (celsius * 9 / 5) + 32;
	}

	static double celsiusParaKelvin(double celsius) {
		return celsius + 273.15;
	}

	static double metrosPorSegundoParaQuilometrosPorHora(double metrosPorSegundo) {
		return metrosPorSegundo * 3.6;
	}

	static double metrosPorSegundoParaMilhasPorHora(double metrosPorSegundo) {
		return metrosPorSegundo * 2.2369362920544;
	}

	static double grausParaRadianos(double graus) {
		return graus * (math.pi / 180);
	}
}
