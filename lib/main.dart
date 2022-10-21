import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: Colors.green[900], secondary: Colors.blueAccent[700]),
            buttonTheme: ButtonThemeData(
                buttonColor: Colors.blueAccent[700],
                textTheme: ButtonTextTheme.primary),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style:
                    ElevatedButton.styleFrom(primary: Colors.blueAccent[700]))),
        home: ListaTransferencia());
  }
}

class FormularioTransferencia extends StatefulWidget {
  FormularioTransferencia({Key? key}) : super(key: key);

  @override
  State<FormularioTransferencia> createState() =>
      _FormularioTransferenciaState();
}

class _FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criando Transferências'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                icone: const Icon(Icons.monetization_on)),
            ElevatedButton(
              onPressed: () => _criaTransferencia(context),
              child: const Text('Confirmar'),
            ),
          ],
        ),
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

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);
  @override
  String toString() {
    return "Tranferencia{valor: $valor, numeroConta: $numeroConta}";
  }
}
