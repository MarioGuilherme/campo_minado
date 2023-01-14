import "package:flutter/material.dart";

class ResultadoWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool? venceu;
  final void Function() onReiniciar;

  const ResultadoWidget({
    required this.venceu,
    required this.onReiniciar,
    Key? key
  }) : super(key: key);

  Color? _getCor() {
    if (this.venceu == null)
      return Colors.yellow;

    if (this.venceu!)
      return Colors.green[300];

    return Colors.red[300];
  }

  IconData _getIcon() {
    if (this.venceu == null)
      return Icons.sentiment_satisfied;

    if (this.venceu!)
      return Icons.sentiment_very_satisfied;

    return Icons.sentiment_very_dissatisfied;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: this._getCor(),
            child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: Icon(
                this._getIcon(),
                color: Colors.black,
                size: 35
              ),
              onPressed: this.onReiniciar
            )
          )
        )
      )
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(120);
}