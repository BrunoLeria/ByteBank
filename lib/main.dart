import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Transferências'),
            backgroundColor: Colors.green[900],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.green[900],
            child: Icon(Icons.add),
          ),
          body: ListaTransferencia(),
        ),
      ),
    );

class ListaTransferencia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
            children: [
              ItemTransferencia(Transferencia(100.00, "Conta 1")),
              ItemTransferencia(Transferencia(500.00, "Conta 2")),
              ItemTransferencia(Transferencia(200.00, "Conta 3")),
            ],
          );
  }
}

class ItemTransferencia extends StatelessWidget{

  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia,);

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

class Transferencia{
  
  final double valor;
  final String nome;

  Transferencia(this.valor, this.nome);
}