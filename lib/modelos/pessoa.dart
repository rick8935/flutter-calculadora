enum Genero { masculino, feminino }

class Pessoa {
  final int idade;
  final Genero genero;
  final double peso;
  final double altura;

  Pessoa({
    required this.idade,
    required this.genero,
    required this.peso,
    required this.altura,
  });

  bool get isValida =>
      idade > 0 && peso > 0 && altura > 0 && altura < 3.0 && peso < 500;
}
