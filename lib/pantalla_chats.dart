import 'package:flutter/material.dart';
import 'package:proyecto/pantalla_principal.dart';
import 'package:proyecto/taskBar.dart';

class ListMessagesScreen extends StatelessWidget {
  const ListMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_ios, size: 16, color: Colors.black),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const PantallaPrincipal(),
                )
            );
          },
        ),
        title: const Text(
          'Messages',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Título y botón de nuevo mensaje
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Messages',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_square, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for chats & messages',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Lista de conversaciones
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              children: const [
                ChatItem(
                  name: 'Sajib Rahman',
                  message: 'Hi, John! 👋 How are you doing?',
                  time: '09:46',
                  avatarColor: Colors.pink,
                  isRead: true,
                  isTyping: false,
                  isOnline: false,
                ),
                ChatItem(
                  name: 'Adom Shafi',
                  message: 'Typing...',
                  time: '08:42',
                  avatarColor: Colors.amber,
                  isRead: true,
                  isTyping: true,
                  isOnline: false,
                ),
                ChatItem(
                  name: 'HR Rumen',
                  message: 'You: Cool! 😎 Let\'s meet at 18:00 near the traveling!',
                  time: 'Yesterday',
                  avatarColor: Colors.pink,
                  isRead: true,
                  isTyping: false,
                  isOnline: true,
                ),
                ChatItem(
                  name: 'Anjelina',
                  message: 'You: Hey, will you come to the party on Saturday?',
                  time: '07:36',
                  avatarColor: Colors.pink,
                  isRead: true,
                  isTyping: false,
                  isOnline: true,
                ),
                ChatItem(
                  name: 'Alexa Shorna',
                  message: 'Thank you for coming! Your or...',
                  time: '05:53',
                  avatarColor: Colors.deepPurple,
                  isRead: true,
                  isTyping: false,
                  isOnline: true,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: TaskBar( selectedIndex: 3,),
    );
  }
}

class ChatItem extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final Color avatarColor;
  final bool isRead;
  final bool isTyping;
  final bool isOnline;

  const ChatItem({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.avatarColor,
    required this.isRead,
    required this.isTyping,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          // Avatar con indicador de estado
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: avatarColor.withOpacity(0.2),
                child: Text(
                  name.substring(0, 1),
                  style: TextStyle(
                    color: avatarColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 12),

          // Contenido del mensaje
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(
                    color: isTyping ? Colors.blue : Colors.grey[600],
                    fontWeight: isTyping ? FontWeight.bold : FontWeight.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Hora y estado de lectura
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              if (isRead)
                Icon(
                  Icons.check,
                  size: 16,
                  color: isTyping ? Colors.green : Colors.grey,
                ),
            ],
          ),
        ],
      ),
    );
  }
}