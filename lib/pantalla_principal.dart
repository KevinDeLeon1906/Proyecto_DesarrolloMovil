import 'package:flutter/material.dart';
import 'package:proyecto/destinoCard.dart';
import 'package:proyecto/pantalla_buscar.dart';
import 'package:proyecto/taskBar.dart';


class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Barra de búsqueda
            SearchBarNavigation(),
            // Contenido principal
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Best Destination',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      DestinoCard(
                        imagePath: 'assets/images/img1.png',
                        location: 'Tequila, Jalisco',
                        rating: 4.7,
                        distance: '80 km',
                      ),

                      const SizedBox(height: 16),

                      DestinoCard(
                        imagePath: 'assets/images/img2.png',
                        location: 'Punta Mita, Mexico',
                        rating: 4.7,
                        distance: '100 km',
                      ),

                      const SizedBox(height: 16),

                      DestinoCard(
                        imagePath: 'assets/images/peace_garden.png',
                        location: 'Jalpan, Queretaro',
                        rating: 4.7,
                        distance: '100 km',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TaskBar(selectedIndex: 0,),
    );
  }
}

class SearchBarNavigation extends StatelessWidget {
  const SearchBarNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchScreen()),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.grey),
              const SizedBox(width: 10),
              Text(
                'Search places',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

