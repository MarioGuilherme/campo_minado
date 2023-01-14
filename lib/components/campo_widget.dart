import "package:flutter/material.dart";

import "package:campo_minado/models/campo.dart";

class CampoWidget extends StatelessWidget {
  final Campo campo;
  final void Function(Campo) onAbrir;
  final void Function(Campo) onAlternarMarcacao;

  const CampoWidget({
    required this.campo,
    required this.onAbrir,
    required this.onAlternarMarcacao,
    Key? key
  }) : super(key: key);

  Widget _getImage() {
    int qtdeMinas = this.campo.qtdeMinasNaVizinhanca;

    if (this.campo.aberto && this.campo.minado && this.campo.explodido)
      return Image.asset("assets/images/bomba_0.jpeg");

    if (this.campo.aberto && this.campo.minado)
      return Image.asset("assets/images/bomba_1.jpeg");

    if (this.campo.aberto)
      return Image.asset("assets/images/aberto_$qtdeMinas.jpeg");

    if (this.campo.marcado)
      return Image.asset("assets/images/bandeira.jpeg");

    return Image.asset("assets/images/fechado.jpeg");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => this.onAbrir(this.campo),
      onLongPress: () => this.onAlternarMarcacao(this.campo),
      child: this._getImage()
    );
  }
}