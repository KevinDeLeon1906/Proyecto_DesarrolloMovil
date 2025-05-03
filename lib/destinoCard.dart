import 'package:flutter/material.dart';
import 'package:proyecto/pantalla_informacion_lugar.dart';

class DestinoCard extends StatelessWidget {
  final String imagePath;
  final String location;
  final double rating;
  final String? distance;
  final Map<String, dynamic>? detallesDestino;

  const DestinoCard({
    super.key,
    required this.imagePath,
    required this.location,
    required this.rating,
    this.distance,
    this.detallesDestino,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DestinoDetalleScreen(
              imagePath: imagePath,
              location: location,
              rating: rating,
              distance: distance,
              detallesDestino: detallesDestino,
            ),
          ),
        );
      },
      splashColor: Colors.pink.withOpacity(0.3),
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imagePath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading image: $error');
                  return Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.error, color: Colors.red),
                    ),
                  );
                },
              )
          ),
          const SizedBox(height: 8),

          // Información del destino
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                location,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                distance ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    rating.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}