import 'package:comersium/backend/backend.dart';
import 'package:flutter/material.dart';

class ReviewSummary extends StatelessWidget {
  final DocumentReference commerceRef;

  const ReviewSummary({super.key, required this.commerceRef});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ReviewRecord>>(
      stream: queryReviewRecord(
        parent: commerceRef,
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final reviews = snapshot.data!;
        if (reviews.isEmpty) {
          return const Text('No reviews yet.');
        }

        // Cálculo del promedio de estrellas
        double averageRating =
            reviews.fold<double>(0.0, (sum, review) => sum + review.rating) /
                reviews.length;

        // Conteo de reseñas por estrellas
        int totalReviews = reviews.length;
        int star5Count = reviews.where((r) => r.rating == 5).length;
        int star4Count = reviews.where((r) => r.rating == 4).length;
        int star3Count = reviews.where((r) => r.rating == 3).length;
        int star2Count = reviews.where((r) => r.rating == 2).length;
        int star1Count = reviews.where((r) => r.rating == 1).length;

        // Cálculo de los porcentajes de reseñas por nivel
        double star5Percentage = star5Count / totalReviews;
        double star4Percentage = star4Count / totalReviews;
        double star3Percentage = star3Count / totalReviews;
        double star2Percentage = star2Count / totalReviews;
        double star1Percentage = star1Count / totalReviews;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            border: BorderDirectional(
              bottom: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Calificación promedio grande
              Column(
                children: [
                  Text(
                    averageRating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    'de 5',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // Barra de desglose de calificaciones
              Expanded(
                child: Column(
                  children: [
                    _buildRatingBar(5, star5Percentage, star5Count),
                    _buildRatingBar(4, star4Percentage, star4Count),
                    _buildRatingBar(3, star3Percentage, star3Count),
                    _buildRatingBar(2, star2Percentage, star2Count),
                    _buildRatingBar(1, star1Percentage, star1Count),
                    const SizedBox(height: 10),
                    Text(
                      '$totalReviews calificaciones',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Construcción de cada barra de reseñas
  Widget _buildRatingBar(int star, double percentage, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          // Estrellas
          Row(
            children: List.generate(
              star,
              (index) => const Icon(
                Icons.star,
                size: 16,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Barra de porcentaje que ocupa siempre el mismo ancho
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: percentage, // Proporcional al porcentaje
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Cantidad de reseñas
          Text(
            '$count',
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
