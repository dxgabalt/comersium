import 'package:flutter/material.dart';

class ReviewStatsWidget extends StatelessWidget {
  const ReviewStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                for (int i = 0; i < 4; i++)
                  const Icon(Icons.circle, color: Colors.greenAccent, size: 16),
                const Icon(Icons.circle_outlined,
                    color: Colors.greenAccent, size: 16),
                const SizedBox(width: 8),
                const Text(
                  "1.817 opiniones",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const ReviewBar(
                label: "Excelente", value: 1112 / 1817, count: 1112),
            const ReviewBar(label: "Muy bien", value: 516 / 1817, count: 516),
            const ReviewBar(label: "Normal", value: 115 / 1817, count: 115),
            const ReviewBar(label: "Mala", value: 56 / 1817, count: 56),
            const ReviewBar(label: "Pésima", value: 18 / 1817, count: 18),
            const SizedBox(height: 24),
            const ReviewScore(label: "Limpieza", score: 4.5),
            const ReviewScore(label: "Ubicación", score: 4.7),
            const ReviewScore(label: "Servicio", score: 4.6),
            const ReviewScore(label: "Valor", score: 4.4),
          ],
        ),
      ),
    );
  }
}

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
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: Colors.white)),
          const SizedBox(width: 16),
          Expanded(
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.grey,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
            ),
          ),
          const SizedBox(width: 16),
          Text(count.toString(), style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class ReviewScore extends StatelessWidget {
  final String label;
  final double score;

  const ReviewScore({
    super.key,
    required this.label,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          score.toString(),
          style: const TextStyle(color: Colors.greenAccent, fontSize: 20),
        ),
        const Icon(Icons.circle, color: Colors.greenAccent, size: 10),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ReviewStatsWidget(),
  ));
}
