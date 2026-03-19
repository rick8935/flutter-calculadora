import 'package:flutter/material.dart';

class MedidorPercentual extends StatelessWidget {
  final double percentual; // Pode ser negativo (abaixo) ou positivo (acima)

  const MedidorPercentual({super.key, required this.percentual});

  @override
  Widget build(BuildContext context) {
    // Limitamos visualmente de -50% a +50%
    final double valorClamp = percentual.clamp(-50.0, 50.0);
    // Transforma o range de [-50, 50] para [0.0, 1.0]
    final double percentualNormalizado = (valorClamp + 50) / 100.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('-50%', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            Text('Ideal (0%)', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            Text('+50%', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 8),
        Container(
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.green, Colors.red],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: MediaQuery.of(context).size.width * 0.8 * percentualNormalizado - 10,
                // O width total é um pouco menor que a tela, faremos uma estimativa via LayoutBuilder ou FractionallySizedBox.
                // Mas de forma mais segura:
                child: Container(),
              ),
              Align(
                alignment: FractionalOffset(percentualNormalizado, 0.5),
                child: Container(
                  width: 16,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          percentual > 0 
            ? 'Você está ${percentual.abs()}% acima do índice ideal.'
            : 'Você está ${percentual.abs()}% abaixo do índice ideal.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
