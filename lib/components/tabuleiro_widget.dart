import "package:flutter/material.dart";

import "package:campo_minado/components/campo_widget.dart";
import "package:campo_minado/models/campo.dart";
import "package:campo_minado/models/tabuleiro.dart";

class TabuleiroWidget extends StatelessWidget {
  final Tabuleiro tabuleiro;
  final void Function(Campo) onAbrir;
  final void Function(Campo) onAlternarMarcacao;

  const TabuleiroWidget({
    required this.tabuleiro,
    required this.onAbrir,
    required this.onAlternarMarcacao,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: this.tabuleiro.colunas,
      children: this.tabuleiro.campos.map((campo) => CampoWidget(
        campo: campo,
        onAbrir: this.onAbrir,
        onAlternarMarcacao: this.onAlternarMarcacao
      )).toList()
    );
  }
}