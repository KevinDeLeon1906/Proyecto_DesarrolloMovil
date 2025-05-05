class RentalHouse {
  final String id;
  final String name;
  final String location;
  final String region;
  final double price;
  final String imagePath;
  final double rating;
  final int reviewCount;
  final double? distance;
  final String? description;
  final String? hostName;
  final String? hostImagePath;
  final List<String>? amenities;

  RentalHouse({
    required this.id,
    required this.name,
    required this.location,
    required this.region,
    required this.price,
    required this.imagePath,
    required this.rating,
    required this.reviewCount,
    this.distance,
    this.description,
    this.hostName,
    this.hostImagePath,
    this.amenities,
  });

  // Método para crear una copia de la casa con algunos valores modificados
  RentalHouse copyWith({
    String? id,
    String? name,
    String? location,
    String? region,
    double? price,
    String? imagePath,
    double? rating,
    int? reviewCount,
    double? distance,
    String? description,
    String? hostName,
    String? hostImagePath,
    List<String>? amenities,
    bool? isFavorite,
  }) {
    return RentalHouse(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      region: region ?? this.region,
      price: price ?? this.price,
      imagePath: imagePath ?? this.imagePath,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      distance: distance ?? this.distance,
      description: description ?? this.description,
      hostName: hostName ?? this.hostName,
      hostImagePath: hostImagePath ?? this.hostImagePath,
      amenities: amenities ?? this.amenities,
    );
  }

  // Método para convertir la casa a un mapa (útil para almacenamiento)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'region': region,
      'price': price,
      'imagePath': imagePath,
      'rating': rating,
      'reviewCount': reviewCount,
      'distance': distance,
      'description': description,
      'hostName': hostName,
      'hostImagePath': hostImagePath,
      'amenities': amenities,
    };
  }

  // Método para crear una casa desde un mapa (útil para recuperar de almacenamiento)
  factory RentalHouse.fromMap(Map<String, dynamic> map) {
    return RentalHouse(
      id: map['id'],
      name: map['name'],
      location: map['location'],
      region: map['region'],
      price: map['price'],
      imagePath: map['imagePath'],
      rating: map['rating'],
      reviewCount: map['reviewCount'],
      distance: map['distance'],
      description: map['description'],
      hostName: map['hostName'],
      hostImagePath: map['hostImagePath'],
      amenities: map['amenities'] != null
          ? List<String>.from(map['amenities'])
          : null,
    );
  }
}