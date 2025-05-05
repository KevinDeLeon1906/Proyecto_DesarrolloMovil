import 'package:flutter/material.dart';
import 'package:proyecto/destinoCard.dart';
import 'package:proyecto/pantalla_buscar.dart';
import 'package:proyecto/pantalla_informacion_lugar.dart';
import 'package:proyecto/rental_house.dart';
import 'package:proyecto/rental_house_repository.dart';
import 'package:proyecto/taskBar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RentalHouseRepository _repository = RentalHouseRepository();
  late List<RentalHouse> _houses;

  @override
  void initState() {
    super.initState();
    _houses = _repository.getAllHouses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen()),
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
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Popular Destinations',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Lista de casas
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _houses.length,
              itemBuilder: (context, index) {
                final house = _houses[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: RentalHouseCard(
                    house: house,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DestinoDetalleScreen(
                            destino: house, // Pass the RentalHouse object
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          TaskBar(selectedIndex: 0),
        ],
      ),
    );
  }
}