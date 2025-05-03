
import 'package:proyecto/rental_house.dart';

class RentalHouseRepository {
  // Simulación de una base de datos con casas de ejemplo
  final List<RentalHouse> _houses = [
    RentalHouse(
      id: '1',
      name: 'Casa roca',
      location: 'Tequila',
      region: 'Jalisco',
      price: 59,
      imagePath: 'assets/images/casa_roca.png',
      rating: 4.7,
      reviewCount: 2498,
      distance: 80,
      description: 'Una hermosa casa en las montañas de Tequila con vistas impresionantes. Perfecta para escapadas de fin de semana.',
      hostName: 'Juan Pérez',
      hostImagePath: 'assets/images/profile.png',
      amenities: ['WiFi', 'Piscina', 'Cocina', 'Estacionamiento', 'Aire acondicionado'],
    ),
    RentalHouse(
      id: '2',
      name: 'Casa Las Tortugas',
      location: 'La Barrita',
      region: 'Mexico',
      price: 89,
      imagePath: 'assets/images/casa_tortugas.png',
      rating: 4.7,
      reviewCount: 1256,
      description: 'Hermosa casa frente al mar con acceso directo a la playa. Disfruta de increíbles atardeceres y la brisa marina.',
      hostName: 'María González',
      hostImagePath: 'assets/images/profile.png',
      amenities: ['WiFi', 'Playa privada', 'Cocina', 'Terraza', 'Vista al mar'],
    ),
    RentalHouse(
      id: '3',
      name: 'Cabaña del Bosque',
      location: 'Tapalpa',
      region: 'Jalisco',
      price: 75,
      imagePath: 'assets/images/peace_garden.png',
      rating: 4.5,
      reviewCount: 987,
      distance: 120,
      description: 'Acogedora cabaña rodeada de pinos. El lugar perfecto para desconectar y disfrutar de la naturaleza.',
      hostName: 'Roberto Sánchez',
      hostImagePath: 'assets/images/profile.png',
      amenities: ['Chimenea', 'Cocina', 'Senderismo', 'Estacionamiento', 'Barbacoa'],
    ),
  ];

  // Obtener todas las casas
  List<RentalHouse> getAllHouses() {
    return _houses;
  }

  // Obtener casa por ID
  RentalHouse? getHouseById(String id) {
    try {
      return _houses.firstWhere((house) => house.id == id);
    } catch (e) {
      return null;
    }
  }

  // Buscar casas por nombre o ubicación
  List<RentalHouse> searchHouses(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _houses.where((house) {
      return house.name.toLowerCase().contains(lowercaseQuery) ||
          house.location.toLowerCase().contains(lowercaseQuery) ||
          house.region.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  // Filtrar casas por precio máximo
  List<RentalHouse> filterByMaxPrice(double maxPrice) {
    return _houses.where((house) => house.price <= maxPrice).toList();
  }

  // Marcar/desmarcar casa como favorita
  RentalHouse toggleFavorite(String id) {
    final index = _houses.indexWhere((house) => house.id == id);
    if (index != -1) {
      final house = _houses[index];
      final updatedHouse = house.copyWith(isFavorite: !house.isFavorite);
      _houses[index] = updatedHouse;
      return updatedHouse;
    }
    throw Exception('Casa no encontrada');
  }
}