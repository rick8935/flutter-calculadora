class ResultadoIMC {
  final double valorImc;
  final String categoriaImc;
  final double percentualDiferenca;
  final String caminhoImagem;
  final String? mensagemAlerta;

  ResultadoIMC({
    required this.valorImc,
    required this.categoriaImc,
    required this.percentualDiferenca,
    required this.caminhoImagem,
    this.mensagemAlerta,
  });
}
