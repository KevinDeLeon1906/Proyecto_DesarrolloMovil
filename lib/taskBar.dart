import 'package:flutter/material.dart';
import 'package:proyecto/constantes.dart' as con;
import 'package:proyecto/pantalla_buscar.dart';
import 'package:proyecto/pantalla_chats.dart';
import 'package:proyecto/pantalla_feed.dart';
import 'package:proyecto/pantalla_login.dart';
import 'package:proyecto/pantalla_principal.dart';

class TaskBar extends StatelessWidget {
  final int selectedIndex;

  const TaskBar({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
              icon: Icon(
                  Icons.home_outlined,
                  color: selectedIndex == 0 ? con.rosa : Colors.grey,
                  size: 30
              ),
              onPressed: () {
                if (selectedIndex != 0) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      )
                  );
                }
              },
            ),
            IconButton(
              icon: Icon(
                  Icons.people_alt_outlined,
                  color: selectedIndex == 1 ? con.rosa : Colors.grey,
                  size: 30
              ),
              onPressed: () {
                if (selectedIndex != 1) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => CommunityScreen(),
                      )
                  );
                }
              },
            ),
            IconButton(
              icon: Icon(
                  Icons.search_outlined,
                  color: selectedIndex == 2 ? con.rosa : Colors.grey,
                  size: 30
              ),
              onPressed: () {
                // Si ya estamos en la pantalla de búsqueda, no hacemos nada
                if (selectedIndex != 2) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      )
                  );
                }
              },
            ),
            IconButton(
              icon: Icon(
                  Icons.message_outlined,
                  color: selectedIndex == 3 ? con.rosa : Colors.grey,
                  size: 30
              ),
              onPressed: () {
                if (selectedIndex != 3) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ListMessagesScreen(),
                      )
                  );
                }
              },
            ),
            IconButton(
              icon: Icon(
                  Icons.person_outline,
                  color: selectedIndex == 4 ? con.rosa : Colors.grey,
                  size: 30
              ),
              onPressed: () {
                if (selectedIndex != 4) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      )
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}