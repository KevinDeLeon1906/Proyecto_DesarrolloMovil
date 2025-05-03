// Pantalla de detalle a la que navegaremos
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DestinoDetalleScreen extends StatelessWidget {
  final String imagePath;
  final String location;
  final double rating;
  final String? distance;
  final Map<String, dynamic>? detallesDestino;

  const DestinoDetalleScreen({
    super.key,
    required this.imagePath,
    required this.location,
    required this.rating,
    this.distance,
    this.detallesDestino,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Imagen principal y encabezado
          Stack(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Botones superiores
              Positioned(
                top: 40,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Botón de regreso
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, size: 16),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),

                    // Título
                    const Text(
                      'Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 1),
                            blurRadius: 3.0,
                            color: Color.fromARGB(150, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),

                    // Botón de compartir
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.save_alt_sharp, size: 16),
                        onPressed: () {
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Contenedor blanco redondeado que se superpone a la imagen
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Contenido principal (detalles)
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título y anfitrión
                    Row(
                      children: [
                        // Título
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                location,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Juan Pérez',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Foto de perfil (puedes reemplazar esto con una imagen real)
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.pink,
                              width: 2,
                            ),
                            color: Colors.grey[300],
                          ),
                          child: const Icon(Icons.person, size: 20),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Ubicación, calificación y precio
                    Row(
                      children: [
                        // Ubicación
                        if (distance != null)
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.grey,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                distance!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),

                        const SizedBox(width: 16),

                        // Calificación
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              rating.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        // Precio (puedes obtener esto de detallesDestino si lo tienes)
                        Text(
                          '\$${detallesDestino?['precio'] ?? 59}',
                          style: TextStyle(
                            color: Colors.pink[500],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '/Person',
                          style: TextStyle(
                            color: Colors.pink[500],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Sección "About Destination"
                    const Text(
                      'About Destination',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Descripción (puedes obtener esto de detallesDestino si lo tienes)
                    Text(
                      detallesDestino?['descripcion'] ??
                          'You will get a complete travel package on the beaches. Packaged in the form of airline tickets, recommended Hotel rooms, Transportation. Have you ever been on holiday to the Greek ETC... Read More',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Botón de reserva
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Acción para reservar
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[500],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Book Now',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}