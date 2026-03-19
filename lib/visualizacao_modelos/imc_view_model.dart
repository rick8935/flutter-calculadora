import 'package:flutter/material.dart';
import '../modelos/pessoa.dart';
import '../modelos/resultado_imc.dart';
import '../utilitarios/calculadora_imc.dart';

class ImcViewModel extends ChangeNotifier {
  ResultadoIMC? _resultadoAtual;

  ResultadoIMC? get resultadoAtual => _resultadoAtual;

  void calcularIMC(double peso, double altura, int idade, Genero genero) {
    // Tratamento de conversão para metros caso a entrada seja em cm
    final double alturaEmMetros = altura > 3.0 ? altura / 100 : altura;

    final pessoa = Pessoa(
      idade: idade,
      genero: genero,
      peso: peso,
      altura: alturaEmMetros,
    );

    try {
      _resultadoAtual = CalculadoraIMC.calcular(pessoa);
      notifyListeners();
    } catch (e) {
      _resultadoAtual = null;
      notifyListeners();
      // Opcionalmente repassar o erro ou gerenciar o estado
    }
  }

  void limpar() {
    _resultadoAtual = null;
    notifyListeners();
  }
}
