import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'telas/tela_inicial.dart';
import 'visualizacao_modelos/imc_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImcViewModel()),
      ],
      child: MeuAppImc(),
    ),
  );
}

class MeuAppImc extends StatelessWidget {
  const MeuAppImc({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      home: TelaInicial(),
    );
  }
}
