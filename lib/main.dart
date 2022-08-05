import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferências'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: TextStyle(
                fontSize: 24.0,
              ),
              decoration: InputDecoration(
                labelText: 'Número da conta',
                hintText: '0000',
              ),
            ),
          ),
          TextField(),
          ElevatedButton(
            onPressed: null,
            child: const Text('Disabled'),
          ),
        ],
      ),
    );
  }
}

class ListaTransferencia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
        backgroundColor: Colors.green[900],
      ),
      body: Column(
        children: [
          ItemTransferencia(Transferencia(100.00, "Conta 1")),
          ItemTransferencia(Transferencia(500.00, "Conta 2")),
          ItemTransferencia(Transferencia(200.00, "Conta 3")),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
        subtitle: Text(_transferencia.nome),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final String nome;

  Transferencia(this.valor, this.nome);
}
