import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final Icon? icone;
  final double tamanhoFonte;

  const Editor(
      {this.controlador,
      this.rotulo,
      this.dica,
      this.icone,
      this.tamanhoFonte = 24.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
          controller: controlador,
          style: TextStyle(
            fontSize: tamanhoFonte,
          ),
          decoration: InputDecoration(
            icon: icone,
            labelText: rotulo,
            hintText: dica,
          ),
          keyboardType: TextInputType.number),
    );
  }
}
