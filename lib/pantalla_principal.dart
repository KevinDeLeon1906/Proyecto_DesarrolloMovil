import 'package:flutter/material.dart';
import 'package:proyecto/destinoCard.dart';

import 'constantes.dart' as con;

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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search places',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),

            // Contenido principal
            Expanded(
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 10),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.grey, size: 40),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.people, color: Colors.grey, size: 40),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.search_outlined, color: con.rosa, size: 40),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.message, color: Colors.grey, size: 40),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.person, color: Colors.grey, size: 40),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

