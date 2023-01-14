import "dart:math";

import "package:campo_minado/models/campo.dart";

class Tabuleiro {
  final int linhas;
  final int colunas;
  final int qtdeBombas;

  final List<Campo> _campos = <Campo>[];

  Tabuleiro({
    required this.linhas,
    required this.colunas,
    required this.qtdeBombas,
  }) {
    this._criarCampos();
    this._relacionarVizinhos();
    this._sortearMinas();
  }

  void reiniciar() {
    this._campos.forEach((campo) => campo.reiniciar());
    this._sortearMinas();
  }

  void revelarBombas() {
    this._campos.forEach((campo) => campo.revelarBomba());
  }

  void _criarCampos() {
    for (int linha = 0; linha < this.linhas; linha++)
      for (int coluna = 0; coluna < this.colunas; coluna++)
        this._campos.add(Campo(linha: linha, coluna: coluna));
  }

  void _relacionarVizinhos() {
    for (Campo campo in this._campos)
      for (Campo vizinho in this._campos)
        campo.adicionarVizinho(vizinho);
  }

  void _sortearMinas() {
    int sorteadas = 0;

    if (this.qtdeBombas > this.linhas * this.colunas) return;

    while (sorteadas < this.qtdeBombas) {
      final int i = Random().nextInt(this._campos.length);
      if (!this._campos[i].minado) {
        sorteadas++;
        this._campos[i].minar();
      }
    }
  }

  List<Campo> get campos => this._campos;

  bool get resolvido => this._campos.every((campo) => campo.resolvido);
}