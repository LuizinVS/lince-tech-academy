class RegistroClima {
	const RegistroClima({
		required this.estado,
		required this.dataHora,
		required this.temperaturaCelsius,
		required this.umidade,
		required this.velocidadeVentoMs,
		required this.direcaoVentoGraus,
	});

	final String estado;
	final DateTime dataHora;
	final double temperaturaCelsius;
	final double umidade;
	final double velocidadeVentoMs;
	final double direcaoVentoGraus;

	int get ano => dataHora.year;

	int get mes => dataHora.month;

	factory RegistroClima.fromCsv({
		required String estado,
		required DateTime dataHora,
		required double temperaturaCelsius,
		required double umidade,
		required double velocidadeVentoMs,
		required double direcaoVentoGraus,
	}) {
		return RegistroClima(
			estado: estado,
			dataHora: dataHora,
			temperaturaCelsius: temperaturaCelsius,
			umidade: umidade,
			velocidadeVentoMs: velocidadeVentoMs,
			direcaoVentoGraus: direcaoVentoGraus,
		);
	}
}
