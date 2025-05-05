import 'package:flutter/material.dart';
import 'package:proyecto/rental_house.dart';

class DestinoDetalleScreen extends StatelessWidget {
  final RentalHouse destino;
  final Function()? onFavoriteToggle;

  const DestinoDetalleScreen({
    super.key,
    required this.destino,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(destino.imagePath),
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

                    // Botón de favorito
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        shape: BoxShape.circle,
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
                                destino.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                destino.hostName ?? 'Anfitrión',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Foto de perfil
                        if (destino.hostImagePath != null)
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.pink,
                                width: 2,
                              ),
                              image: DecorationImage(
                                image: AssetImage(destino.hostImagePath!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        else
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
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.grey,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              destino.region,
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
                              '${destino.rating} (${destino.reviewCount})',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        // Precio
                        Text(
                          '\$${destino.price.toInt()}',
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

                    const SizedBox(height: 16),

                    // Iconos de amenidades
                    if (destino.amenities != null && destino.amenities!.isNotEmpty)
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: destino.amenities!.length,
                          itemBuilder: (context, index) {
                            return _buildAmenityIcon(destino.amenities![index]);
                          },
                        ),
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

                    // Descripción
                    Text(
                      destino.description ?? 'No hay descripción disponible.',
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
                        child: const Text(
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

  // Widget para los iconos de amenidades
  Widget _buildAmenityIcon(String amenity) {
    IconData iconData;

    // Asignar icono según el tipo de amenidad
    switch (amenity.toLowerCase()) {
      case 'wifi':
        iconData = Icons.wifi;
        break;
      case 'piscina':
        iconData = Icons.pool;
        break;
      case 'cocina':
        iconData = Icons.kitchen;
        break;
      case 'estacionamiento':
        iconData = Icons.local_parking;
        break;
      case 'aire acondicionado':
        iconData = Icons.ac_unit;
        break;
      case 'playa privada':
        iconData = Icons.beach_access;
        break;
      case 'terraza':
        iconData = Icons.deck;
        break;
      case 'vista al mar':
        iconData = Icons.water;
        break;
      case 'chimenea':
        iconData = Icons.fireplace;
        break;
      case 'senderismo':
        iconData = Icons.hiking;
        break;
      case 'barbacoa':
        iconData = Icons.outdoor_grill;
        break;
      default:
        iconData = Icons.check_circle;
    }

    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        iconData,
        color: Colors.grey[700],
        size: 24,
      ),
    );
  }
}