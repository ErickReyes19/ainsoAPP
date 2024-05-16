import 'package:flutter/material.dart';

import 'textsecundario.widget.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    Key? key,
    required this.tema,
    required this.size,
  }) : super(key: key);

  final ColorScheme tema;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Icon(
            Icons.upcoming_outlined,
            color: tema.secondary,
            size: size.height * 0.2,
          ),
          const TextSecundario(
              texto: 'No hay datos para mostrar')
        ],
      );
  }
}
