import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../visualizacao_modelos/imc_view_model.dart';
import '../componentes/medidor_percentual.dart';

class TelaResultado extends StatefulWidget {
  const TelaResultado({super.key});

  @override
  State<TelaResultado> createState() => _TelaResultadoState();
}

class _TelaResultadoState extends State<TelaResultado> {
  Timer? _timer;
  bool _isRed = false;
  bool _isObeso = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final resultado = Provider.of<ImcViewModel>(context, listen: false).resultadoAtual;
      if (resultado != null && resultado.mensagemAlerta != null) {
        setState(() {
          _isObeso = true;
        });
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
          if (mounted) {
            setState(() {
              _isRed = !_isRed;
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    if (_isObeso) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ImcViewModel>(context);
    final resultado = viewModel.resultadoAtual;

    Color? backgroundColor;
    if (_isObeso) {
      backgroundColor = _isRed ? Colors.red : Colors.black;
    }

    // Usando uma cor de texto que contraste com o fundo piscante
    final textColor = _isObeso ? Colors.white : Colors.grey[700];
    final titleColor = _isObeso ? Colors.white : Colors.teal[800];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _isObeso ? null : AppBar(
        title: const Text('Seu Resultado'),
        backgroundColor: Colors.teal,
      ),
      body: resultado == null
          ? const Center(child: Text('Nenhum resultado disponível.', style: TextStyle(fontSize: 18)))
          : SafeArea(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Índice de Massa Corporal',
                      style: TextStyle(fontSize: 20, color: textColor),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      resultado.valorImc.toString(),
                      style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: _isObeso ? Colors.white : Colors.teal),
                    ),
                    Text(
                      resultado.categoriaImc,
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: titleColor),
                    ),
                    if (resultado.mensagemAlerta != null) ...[
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red, width: 2),
                        ),
                        child: Text(
                          resultado.mensagemAlerta!,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red[900]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    const SizedBox(height: 40),
                    
                    // Imagem gerada correspondente
                    Image.asset(
                      resultado.caminhoImagem,
                      height: 250,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 200, color: Colors.grey),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Medidor Percentual
                    MedidorPercentual(percentual: resultado.percentualDiferenca),

                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isObeso ? Colors.red[900] : Colors.teal,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('REFAZER CÁLCULO', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          viewModel.limpar();
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
          ),
    );
  }
}
