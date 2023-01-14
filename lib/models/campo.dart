import 'package:campo_minado/models/explosao_exception.dart';

class Campo {
  final int linha;
  final int coluna;
  final List<Campo> vizinhos = <Campo>[];

  bool _estaAberto = false;
  bool _estaMarcado = false;
  bool _estaMinado = false;
  bool _estaExplodido = false;

  Campo({
    required this.linha,
    required this.coluna
  });

  void adicionarVizinho(Campo vizinho) {
    final deltaLinha = (this.linha - vizinho.linha).abs();
    final deltaColuna = (this.coluna - vizinho.coluna).abs();

    if (deltaLinha == 0 && deltaColuna == 0) return;

    if (deltaLinha <= 1 && deltaColuna <= 1)
      this.vizinhos.add(vizinho);
  }

  void abrir() {
    if (this._estaAberto) return;

    this._estaAberto = true;

    if (this._estaMinado) {
      this._estaExplodido = true;
      throw ExplosaoException();
    }

    if (this.vizinhancaSegura)
      this.vizinhos.forEach((vizinho) => vizinho.abrir());
  }

  void revelarBomba() {
    if (this._estaMinado)
      this._estaAberto = true;
  }

  void minar() {
    this._estaMinado = true;
  }

  void alternarMarcacao() {
    this._estaMarcado = !this._estaMarcado;
  }

  void reiniciar() {
    this._estaAberto = false;
    this._estaMarcado = false;
    this._estaMinado = false;
    this._estaExplodido = false;
  }

  bool get minado => this._estaMinado;

  bool get explodido => this._estaExplodido;

  bool get aberto => this._estaAberto;

  bool get marcado => this._estaMarcado;

  bool get resolvido {
    bool minadoEMarcado = this.minado && this.marcado;
    bool seguroEAberto = !this.minado && this.aberto;
    return minadoEMarcado || seguroEAberto;
  }

  bool get vizinhancaSegura => this.vizinhos.every((vizinho) => !vizinho.minado);

  int get qtdeMinasNaVizinhanca => this.vizinhos.where((vizinho) => vizinho.minado).length;
}