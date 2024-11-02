import 'package:flutter/material.dart';

class ReviewBar extends StatelessWidget {
  final String label;
  final double value;
  final int count;

  const ReviewBar({
    super.key,
    required this.label,
    required this.value,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 70, // Ancho fijo para el texto de la etiqueta
            child: Text(
              label,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10),
          // Contenedor con ancho fijo para la barra base
          Container(
            width: 200, // Ancho fijo para todas las barras
            height: 10,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width:
                    200 * value, // El ancho de la barra verde depende del valor
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            count.toString(),
            style: const TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
