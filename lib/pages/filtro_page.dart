import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/pontos_turisticos.dart';

class FiltroPage extends StatefulWidget {
  static const routeName = '/filtro';
  static const chaveCampoOrdenacao = 'campoOrdenacao';
  static const chaveUsarOrdemDecrescente = 'usarOrdemDecrescente';
  static const chaveCampoDescricao = 'campoDescricao';

  @override
  _FiltroPageState createState() => _FiltroPageState();
}

class _FiltroPageState extends State<FiltroPage> {
  final _camposParaOrdenacao = {
    PontosTuristicos.campoId: "Código",
    PontosTuristicos.campoDescricao: "Descrição",
    PontosTuristicos.campoCep: "Cep",
    PontosTuristicos.campoInclusao: "Inclusão"
  };

  late SharedPreferences _prefs;
  final _descricaoController = TextEditingController();
  String _campoOrdenacao = PontosTuristicos.campoId;
  bool _usarOrdemDecrescente = false;
  bool _alterouValores = false;

  @override
  void initState() {
    super.initState();
    _carregaDadosSharedPreferences();
  }

  void _carregaDadosSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _campoOrdenacao = _prefs.getString(FiltroPage.chaveCampoOrdenacao) ?? PontosTuristicos.campoId;
      _usarOrdemDecrescente = _prefs.getBool(FiltroPage.chaveUsarOrdemDecrescente) == true;
      _descricaoController.text = _prefs.getString(FiltroPage.chaveCampoDescricao) ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Filtro e Ordenação'),
        ),
        body: _criaBody(),
      ),
      onWillPop: _onVoltarClick,
    );
  }

  Widget _criaBody() {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Text('Campo para ordenação'),
        ),
        for (final campo in _camposParaOrdenacao.keys)
          Row(
            children: [
              Radio(
                value: campo,
                groupValue: _campoOrdenacao,
                onChanged: _onCampoParaOrdenacaoChanged,
              ),
              Text(_camposParaOrdenacao[campo]!),
            ],
          ),
        Divider(),
        Row(
          children: [
            Checkbox(
              value: _usarOrdemDecrescente,
              onChanged: _onUsarOrdemDecrescenteChanged,
            ),
            Text("Decrescente"),
          ],
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            decoration: InputDecoration(labelText: "Começa em: "),
            controller: _descricaoController,
            onChanged: _onFiltroDescricaoChanged,
          ),
        ),
      ],
    );
  }

  void _onCampoParaOrdenacaoChanged(String? valor) {
    _prefs.setString(FiltroPage.chaveCampoOrdenacao, valor!);
    _alterouValores = true;
    setState(() {
      _campoOrdenacao = valor;
    });
  }

  void _onUsarOrdemDecrescenteChanged(bool? valor) {
    _prefs.setBool(FiltroPage.chaveUsarOrdemDecrescente, valor!);
    _alterouValores = true;
    setState(() {
      _usarOrdemDecrescente = valor;
    });
  }

  void _onFiltroDescricaoChanged(String? valor) {
    _prefs.setString(FiltroPage.chaveCampoDescricao, valor!);
    _alterouValores = true;
  }

  Future<bool> _onVoltarClick() async {
    Navigator.of(context).pop(_alterouValores);
    return true;
  }
}
