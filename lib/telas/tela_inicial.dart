import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../visualizacao_modelos/imc_view_model.dart';
import 'tela_resultado.dart';
import '../modelos/pessoa.dart'; // Para acessar o enum Genero

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  final _pesoCtrl = TextEditingController();
  final _alturaCtrl = TextEditingController();
  final _idadeCtrl = TextEditingController();
  Genero _generoSelecionado = Genero.masculino;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
             Icon(Icons.health_and_safety, size: 80, color: Colors.teal),
             SizedBox(height: 20),
             Text('Insira seus dados', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
             SizedBox(height: 30),
             
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 ChoiceChip(
                   label: Text('Masculino'),
                   selected: _generoSelecionado == Genero.masculino,
                   onSelected: (val) {
                     setState(() => _generoSelecionado = Genero.masculino);
                   },
                 ),
                 ChoiceChip(
                   label: Text('Feminino'),
                   selected: _generoSelecionado == Genero.feminino,
                   onSelected: (val) {
                     setState(() => _generoSelecionado = Genero.feminino);
                   },
                 ),
               ],
             ),
             SizedBox(height: 20),
             
             TextField(
               controller: _pesoCtrl,
               keyboardType: TextInputType.numberWithOptions(decimal: true),
               decoration: InputDecoration(
                 labelText: 'Peso (kg)',
                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                 prefixIcon: Icon(Icons.monitor_weight),
               ),
             ),
             SizedBox(height: 20),
             
             TextField(
               controller: _alturaCtrl,
               keyboardType: TextInputType.numberWithOptions(decimal: true),
               decoration: InputDecoration(
                 labelText: 'Altura (m)',
                 hintText: 'Ex: 1.75',
                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                 prefixIcon: Icon(Icons.height),
               ),
             ),
             SizedBox(height: 20),
             
             TextField(
               controller: _idadeCtrl,
               keyboardType: TextInputType.number,
               decoration: InputDecoration(
                 labelText: 'Idade (anos)',
                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                 prefixIcon: Icon(Icons.cake),
               ),
             ),
             SizedBox(height: 40),
             
             SizedBox(
               width: double.infinity,
               height: 56,
               child: ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.teal,
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                 ),
                 child: Text('CALCULAR IMC', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                 onPressed: () {
                   final double peso = double.tryParse(_pesoCtrl.text.replaceAll(',', '.')) ?? 0;
                   final double altura = double.tryParse(_alturaCtrl.text.replaceAll(',', '.')) ?? 0;
                   final int idade = int.tryParse(_idadeCtrl.text) ?? 0;

                   if (peso <= 0 || altura <= 0 || idade <= 0) {
                     ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text('Por favor, preencha todos os campos corretamente!'))
                     );
                     return;
                   }

                   final imcViewModel = Provider.of<ImcViewModel>(context, listen: false);
                   imcViewModel.calcularIMC(peso, altura, idade, _generoSelecionado);

                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (_) => TelaResultado())
                   );
                 },
               )
             )
          ],
        ),
      ),
    );
  }
}
