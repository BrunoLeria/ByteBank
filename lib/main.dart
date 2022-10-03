import 'dart:ffi';

import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferências'),
      ),
      body: Column(
        children: <Widget>[
          Editor(
            controlador: _controladorCampoNumeroConta,
            rotulo: 'Número da conta',
            dica: '0000',
          ),
          Editor(
              controlador: _controladorCampoValor,
              rotulo: 'Valor',
              dica: '0.00',
              icone: Icon(Icons.monetization_on)),
          ElevatedButton(
            onPressed: () => _criaTransferencia(context),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);
    if (numeroConta != null && valor != null) {
      final tranferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('Criando transferencia.');
      debugPrint('$tranferenciaCriada');
      Navigator.pop(context, tranferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final Icon? icone;
  final double tamanhoFonte;

  Editor(
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

class ListaTransferencia extends StatelessWidget {
  final List<Transferencia?> _transferencias = List();

  @override
  Widget build(BuildContext context) {
    _transferencias.add(Transferencia(100.0, 1000));
    _transferencias.add(Transferencia(100.0, 1000));
    _transferencias.add(Transferencia(100.0, 1000));
    _transferencias.add(Transferencia(100.0, 1000));
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
        backgroundColor: Colors.green[900],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final transferencia = _transferencias[index];
          return ItemTransferencia(transferencia);
        },
        itemCount: _transferencias.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<Transferencia?> future =
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return FormularioTransferencia();
          })));
          future.then((tranferenciaRecebida) {
            debugPrint('Chegou no then do future');
            debugPrint('$tranferenciaRecebida');
            _transferencias.add(tranferenciaRecebida);
          });
        },
        backgroundColor: Colors.green[900],
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(
    this._transferencia,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);
  @override
  String toString() {
    // TODO: implement toString
    return "Tranferencia{valor: $valor, numeroConta: $numeroConta}";
  }
}
