import '../modelos/pessoa.dart';
import '../modelos/resultado_imc.dart';

class CalculadoraIMC {
  static ResultadoIMC calcular(Pessoa pessoa) {
    if (!pessoa.isValida) {
      throw Exception('Valores inválidos para cálculo.');
    }

    // Calcula o IMC: Peso (kg) / (Altura(m) * Altura(m))
    final imc = pessoa.peso / (pessoa.altura * pessoa.altura);

    String categoria = '';
    String imagem = '';
    String? mensagem;

    // Classificação
    if (imc < 18.5) {
      categoria = 'Abaixo do peso';
      imagem = 'assets/images/imc_abaixo_peso.png';
    } else if (imc >= 18.5 && imc < 25.0) {
      categoria = 'Peso normal';
      imagem = 'assets/images/imc_normal.png';
    } else if (imc >= 25.0 && imc < 30.0) {
      categoria = 'Sobrepeso';
      imagem = 'assets/images/imc_sobrepeso.png';
    } else if (imc >= 30.0 && imc < 40.0) {
      categoria = 'Obesidade';
      imagem = 'assets/images/imc_obesidade.png';
      mensagem = 'Vai emagrecer, seu rolha de poço! Larga esse lanche e vai treinar!';
    } else {
      categoria = 'Obesidade Extrema';
      imagem = 'assets/images/imc_obesidade_extrema.png';
      mensagem = 'Tá parecendo um planeta de tão gordo! Crie vergonha na cara, desgraça!';
    }

    // Calculando percentual de diferença para o IMC ideal central (22.0)
    // Se o resultado for negativo, está X% abaixo do ideal. Positivo, X% acima.
    final double imcIdeal = 22.0;
    final diferenca = ((imc - imcIdeal) / imcIdeal) * 100;

    return ResultadoIMC(
      valorImc: double.parse(imc.toStringAsFixed(1)),
      categoriaImc: categoria,
      percentualDiferenca: double.parse(diferenca.toStringAsFixed(1)),
      caminhoImagem: imagem,
      mensagemAlerta: mensagem,
    );
  }
}
