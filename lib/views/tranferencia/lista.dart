import 'package:flutter/material.dart';

import '../../models/transferencia.dart';
import 'formulario.dart';

class ListaTransferenciaState extends State<ListaTransferencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, index) {
          final transferencia = widget._transferencias[index];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<Transferencia?> future =
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return FormularioTransferencia();
          })));

          future.then((tranferenciaRecebida) {
            Future.delayed(Duration(seconds: 5), () {
              debugPrint('chegou no then do future');
              debugPrint('$tranferenciaRecebida');
              setState(() {
                widget._transferencias.add(tranferenciaRecebida);
              });
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ListaTransferencia extends StatefulWidget {
  final List<Transferencia?> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia? _transferencia;

  const ItemTransferencia(
    this._transferencia,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text(_transferencia!.valor.toString()),
        subtitle: Text(_transferencia!.numeroConta.toString()),
      ),
    );
  }
}
