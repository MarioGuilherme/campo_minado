import 'package:campo_minado/models/explosao_exception.dart';
import "package:flutter/material.dart";

import "package:campo_minado/components/resultado_widget.dart";
import "package:campo_minado/components/tabuleiro_widget.dart";
import "package:campo_minado/models/campo.dart";
import "package:campo_minado/models/tabuleiro.dart";

class CampoMinadoApp extends StatefulWidget {
  const CampoMinadoApp({Key? key}) : super(key: key);

  @override
  State<CampoMinadoApp> createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  bool? _venceu;
  Tabuleiro? _tabuleiro;

  void _reiniciar() {
    setState(() {
      this._venceu = null;
      this._tabuleiro!.reiniciar();
    });
  }

  void _abrir(Campo campo) {
    if (this._venceu != null) return;
    setState(() {
      try {
        campo.abrir();

        if (this._tabuleiro!.resolvido)
          this._venceu = true;
      } on ExplosaoException {
        this._venceu = false;
        this._tabuleiro!.revelarBombas();
      }
    });
  }

  void _alternarMarcacao(Campo campo) {
    if (this._venceu != null) return;
    setState(() {
      campo.alternarMarcacao();
      if (this._tabuleiro!.resolvido)
        this._venceu = true;
    });
  }

  Tabuleiro _getTabuleiro(double largura, double altura) {
    if (this._tabuleiro == null) {
      int qtdeColunas = 15;
      double tamanhoCampo = largura / qtdeColunas;
      int qtdeLinhas = (altura / tamanhoCampo).floor();
      this._tabuleiro = Tabuleiro(
        linhas: qtdeLinhas,
        colunas: qtdeColunas,
        qtdeBombas: ((qtdeColunas * qtdeLinhas) * .25).floor()
      );
    }

    return this._tabuleiro!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: ResultadoWidget(
          venceu: this._venceu,
          onReiniciar: this._reiniciar
        ),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (context, constraints) => TabuleiroWidget(
              tabuleiro: this._getTabuleiro(constraints.maxWidth, constraints.maxHeight),
              onAbrir: this._abrir,
              onAlternarMarcacao: this._alternarMarcacao
            )
          )
        )
      )
    );
  }
}