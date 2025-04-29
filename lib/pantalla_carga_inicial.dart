import 'package:flutter/material.dart';
import 'package:proyecto/pantalla_principal.dart';
import 'package:proyecto/constantes.dart' as con;

class PantallaCargaInicial extends StatefulWidget {
  const PantallaCargaInicial({super.key});

  @override
  State<PantallaCargaInicial> createState() => _PantallaCargaInicialState();
}

class _PantallaCargaInicialState extends State<PantallaCargaInicial> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
       Navigator.of(context).pushReplacement(
         MaterialPageRoute(builder: (context) => PantallaPrincipal()),
       );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Color rosa brillante similar al de la imagen
      backgroundColor: con.rosa,
      body: Center(
        child: Text(
          'NUMI',
          style: TextStyle(
            color: Colors.black,
            fontSize: 60,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontFamily: 'Katibeh'
          ),
        ),
      ),
    );
  }
}