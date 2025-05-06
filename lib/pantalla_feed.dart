import 'package:flutter/material.dart';
import 'package:proyecto/commentsCard.dart';
import 'package:proyecto/constantes.dart' as con;
import 'package:proyecto/historiaCard.dart';
import 'package:proyecto/pantalla_informacion_lugar.dart';
import 'package:proyecto/rental_house_repository.dart';
import 'package:proyecto/taskBar.dart';
import 'package:proyecto/rental_house.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final RentalHouseRepository _repository = RentalHouseRepository();
  late List<RentalHouse> _houses;
  late RentalHouse _recommendedHouse;

  @override
  void initState() {
    super.initState();
    _houses = _repository.getAllHouses();
    // Select a house to recommend (you could use different criteria)
    _recommendedHouse = _houses.first;
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360;
    final horizontalPadding = screenWidth * 0.04; // 4% of screen width

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.03),

                      Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: screenHeight * 0.02),

                            // Saludo
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      fontSize: isSmallScreen ? 14 : 16,
                                      color: Colors.black
                                  ),
                                  children: const [
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
                            ),

                            SizedBox(height: screenHeight * 0.01),

                            // Let's travel - Responsive text size
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                              child: Text(
                                'Let\'s travel',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 20 : 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.02),

                            // Categorías de viaje - Fixed height container
                            SizedBox(
                              height: 100, // Fixed height
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                                itemCount: 10, // Number of categories
                                itemBuilder: (context, index) {
                                  // List of categories with their colors
                                  final categories = [
                                    {'name': 'Playa', 'image': 'images/story/playa/playa.png', 'story_image' : 'images/story/playa/playa_story.png',  'color': con.rosa},
                                    {'name': 'Tropical', 'image': 'images/story/tropical/tropical.png', 'story_image' : 'images/story/tropical/tropical_story.png' ,'color': con.rosa},
                                    {'name': 'Cabana', 'image': 'images/story/cabana/cabana.png', 'story_image' : 'images/story/cabana/cabana_story.png', 'color': con.rosa},
                                    {'name': 'Montaña', 'image': 'images/story/montana/montana.png', 'story_image' : 'images/story/montana/montana_story.png' ,'color': con.rosa},
                                    {'name': 'Lago', 'image': 'images/story/lago/lago.png', 'story_image' : 'images/story/lago/lago_story.png', 'color': con.rosa},
                                  ];

                                  final category = categories[index % 5]; // Cycle through the 5 categories

                                  return TravelCategory(
                                    image: category['image'] as String,
                                    storyImage: category['story_image'] as String,
                                    name: category['name'] as String,
                                    color: category['color'] as Color,
                                    size: 70,
                                  );
                                },
                              ),
                            ),

                            // Divider to separate fixed header from scrollable content
                            Divider(height: 1, thickness: 1, color: Colors.grey[200]),
                          ],
                        ),
                      ),

                      // Recomendación destacada
                      RecommendationCard(
                        house: _recommendedHouse,
                        isSmallScreen: isSmallScreen,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        onCommentTap: () {
                          _showCommentsBottomSheet(context);
                        },
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DestinoDetalleScreen(
                                destino: _recommendedHouse,
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      // Ubicaciones populares - Responsive text
                      Text(
                        'Popular Locations near you!',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 16 : 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // Tarjetas de ubicaciones populares
                      Row(
                        children: [
                          Expanded(
                            child: _houses.length > 1 ? PopularLocationCard(
                              image: _houses[1].imagePath,
                              title: _houses[1].name,
                              location: '${_houses[1].location}, ${_houses[1].region}',
                              height: screenHeight * 0.2,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DestinoDetalleScreen(
                                      destino: _houses[1],
                                    ),
                                  ),
                                );
                              },
                            ) : Container(),
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          Expanded(
                            child: _houses.length > 2 ? PopularLocationCard(
                              image: _houses[2].imagePath,
                              title: _houses[2].name,
                              location: '${_houses[2].location}, ${_houses[2].region}',
                              height: screenHeight * 0.2,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DestinoDetalleScreen(
                                      destino: _houses[2],
                                    ),
                                  ),
                                );
                              },
                            ) : Container(),
                          ),
                        ],
                      ),

                      // Bottom spacing to avoid content being hidden by bottom navigation
                      SizedBox(height: screenHeight * 0.1),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const TaskBar(selectedIndex: 1),
    );
  }

  // Show comments bottom sheet
  void _showCommentsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return CommentsSheet(scrollController: scrollController);
        },
      ),
    );
  }
}

// New widget for recommendation card
class RecommendationCard extends StatelessWidget {
  final RentalHouse house;
  final bool isSmallScreen;
  final double screenWidth;
  final double screenHeight;
  final VoidCallback onCommentTap;
  final VoidCallback? onTap;

  const RecommendationCard({
    super.key,
    required this.house,
    required this.isSmallScreen,
    required this.screenWidth,
    required this.screenHeight,
    required this.onCommentTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encabezado con perfil - Responsive layout
          Row(
            children: [
              // Imagen de perfil - Fixed size
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(house.hostImagePath ?? 'images/profile.png'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: con.rosa,
                    width: 2,
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.03),

              // Nombre y ubicación - Flexible width
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            house.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: isSmallScreen ? 14 : 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          'Recommended',
                          style: TextStyle(
                            color: con.rosa,
                            fontSize: isSmallScreen ? 10 : 12,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      house.hostName ?? 'Host',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: isSmallScreen ? 12 : 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Distancia - Flexible width
              if (house.distance != null)
                Flexible(
                  flex: 1,
                  child: Text(
                    '${house.distance}km away',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: isSmallScreen ? 12 : 14,
                    ),
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),

          SizedBox(height: screenHeight * 0.015),

          // Imagen principal - Responsive height
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 16/9, // Maintain aspect ratio
              child: Image.asset(
                house.imagePath,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading image: $error');
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.error, color: Colors.red),
                    ),
                  );
                },
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.015),

          // Likes y comentarios - Responsive spacing
          Row(
            children: [
              LikeButton(
                onLikeChanged: (isLiked) {
                  // updateLikeCount(postId, isLiked);
                },
                iconSize: isSmallScreen ? 20 : 24,
              ),
              SizedBox(width: screenWidth * 0.01),
              Text(
                '${house.reviewCount ~/ 20}', // Using reviewCount to simulate likes
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                ),
              ),
              SizedBox(width: screenWidth * 0.04),

              // Comment button with functionality
              CommentButton(
                count: house.reviewCount ~/ 10, // Using reviewCount to simulate comments
                iconSize: isSmallScreen ? 20 : 24,
                onTap: onCommentTap,
              ),

              const Spacer(),
              Icon(
                Icons.more_horiz,
                color: Colors.grey,
                size: isSmallScreen ? 20 : 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// Widget para tarjetas de ubicaciones populares - Updated with onTap
class PopularLocationCard extends StatelessWidget {
  final String image;
  final String title;
  final String location;
  final double height;
  final VoidCallback? onTap;

  const PopularLocationCard({
    super.key,
    required this.image,
    required this.title,
    required this.location,
    required this.height,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final titleSize = height * 0.07; // Font size proportional to card height
    final locationSize = height * 0.06;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
            onError: (exception, stackTrace) {
              print('Error loading image: $exception');
            },
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
          padding: EdgeInsets.all(height * 0.06),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: titleSize,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: height * 0.02),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: locationSize,
                  ),
                  SizedBox(width: height * 0.02),
                  Expanded(
                    child: Text(
                      location,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: locationSize,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// LikeButton widget
class LikeButton extends StatefulWidget {
  final Function(bool)? onLikeChanged;
  final bool initialLiked;
  final double iconSize;

  const LikeButton({
    super.key,
    this.onLikeChanged,
    this.initialLiked = false,
    this.iconSize = 24,
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
      borderRadius: BorderRadius.circular(widget.iconSize),
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
        padding: EdgeInsets.all(widget.iconSize * 0.3),
        child: Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          color: isLiked ? con.rosa : Colors.grey,
          size: widget.iconSize,
        ),
      ),
    );
  }
}