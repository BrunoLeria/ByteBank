import 'package:flutter/material.dart';

import '../../models/transferencia.dart';
import 'formulario.dart';

const _tituloAppBar = 'Transferências';

class ListaTransferenciaState extends State<ListaTransferencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
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
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return FormularioTransferencia();
          }))).then(
            (tranferenciaRecebida) => _atualiza(tranferenciaRecebida),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _atualiza(Transferencia? tranferenciaRecebida) {
    setState(() {
      widget._transferencias.add(tranferenciaRecebida);
    });
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
