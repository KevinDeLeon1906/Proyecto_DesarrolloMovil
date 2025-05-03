import 'package:flutter/material.dart';
import 'package:proyecto/constantes.dart' as con;
import 'package:proyecto/taskBar.dart';


class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // Saludo
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(text: 'Hi, '),
                      TextSpan(
                        text: 'Fernando',
                        style: TextStyle(
                          color: con.rosa,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Let's travel
                const Text(
                  'Let\'s travel',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                // Categorías de viaje
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      TravelCategory(
                        image: 'assets/images/playa.png',
                        name: 'Playa',
                        color: Colors.orange,
                      ),
                      TravelCategory(
                        image: 'assets/images/tropical.png',
                        name: 'Tropical',
                        color: Colors.pink,
                      ),
                      TravelCategory(
                        image: 'assets/images/cabana.png',
                        name: 'Cabana',
                        color: Colors.blue,
                      ),
                      TravelCategory(
                        image: 'assets/images/montana.png',
                        name: 'Montaña',
                        color: Colors.brown,
                      ),
                      TravelCategory(
                        image: 'assets/images/lago.png',
                        name: 'Lago',
                        color: Colors.red,
                      ),
                      TravelCategory(
                        image: 'assets/images/playa.png',
                        name: 'Playa',
                        color: Colors.orange,
                      ),
                      TravelCategory(
                        image: 'assets/images/tropical.png',
                        name: 'Tropical',
                        color: Colors.pink,
                      ),
                      TravelCategory(
                        image: 'assets/images/cabana.png',
                        name: 'Cabana',
                        color: Colors.blue,
                      ),
                      TravelCategory(
                        image: 'assets/images/montana.png',
                        name: 'Montaña',
                        color: Colors.brown,
                      ),
                      TravelCategory(
                        image: 'assets/images/lago.png',
                        name: 'Lago',
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Recomendación destacada
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Encabezado con perfil
                    Row(
                      children: [
                        // Imagen de perfil
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image: AssetImage('assets/images/profile.png'),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: con.rosa,
                              width: 2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Nombre y ubicación
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  'Peace Garden',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Recommended',
                                  style: TextStyle(
                                    color: con.rosa,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              'Parra de la Fuente',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // Distancia
                        const Text(
                          '10km away',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Imagen principal
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/peace_garden.png',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Likes y comentarios
                    Row(
                      children: [
                        LikeButton(
                          onLikeChanged: (isLiked) {
                            // updateLikeCount(postId, isLiked);
                          },
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          '67',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.grey,
                          size: 24,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          '137',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.more_horiz,
                          color: Colors.grey,
                          size: 24,
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Ubicaciones populares
                const Text(
                  'Popular Locations near you!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                // Tarjetas de ubicaciones populares
                Row(
                  children: const [
                    Expanded(
                      child: PopularLocationCard(
                        image: 'assets/images/emerald.png',
                        title: 'The Beauty of Emerald Pleasures',
                        location: 'Quinta Villas, Mexico',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: PopularLocationCard(
                        image: 'assets/images/treehouse.png',
                        title: 'Colorful tree house in Jalpa',
                        location: 'Jalpa',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: TaskBar( selectedIndex: 1,),
    );
  }
}

// Widget para categorías de viaje
class TravelCategory extends StatelessWidget {
  final String image;
  final String name;
  final Color color;

  const TravelCategory({
    super.key,
    required this.image,
    required this.name,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          // Imagen circular con borde
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: color,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ClipOval(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print('Error loading image: $error');
                    return Container(
                      height: 180,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Center(
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    );
                  },
                )
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Nombre de la categoría
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget para tarjetas de ubicaciones populares
class PopularLocationCard extends StatelessWidget {
  final String image;
  final String title;
  final String location;

  const PopularLocationCard({
    super.key,
    required this.image,
    required this.title,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 12,
                ),
                const SizedBox(width: 4),
                Text(
                  location,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  final Function(bool)? onLikeChanged;
  final bool initialLiked;

  const LikeButton({
    super.key,
    this.onLikeChanged,
    this.initialLiked = false,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.initialLiked;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        setState(() {
          isLiked = !isLiked;
        });

        // Notificar al padre sobre el cambio si se proporcionó un callback
        if (widget.onLikeChanged != null) {
          widget.onLikeChanged!(isLiked);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          color: isLiked ? con.rosa : Colors.grey,
          size: 24,
        ),
      ),
    );
  }
}