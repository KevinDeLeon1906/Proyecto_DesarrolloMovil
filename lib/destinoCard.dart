import 'package:flutter/material.dart';
import 'package:proyecto/rental_house.dart';

class RentalHouseCard extends StatelessWidget {
  final RentalHouse house;
  final Function()? onTap;

  const RentalHouseCard({
    super.key,
    required this.house,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width to make card responsive
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image container with responsive height
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9, // Maintain consistent aspect ratio
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      house.imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
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

              ],
            ),

            // Padding that adapts to screen size
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: isSmallScreen ? 6.0 : 8.0,
                horizontal: 4.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and rating row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and location with flexible width
                      Expanded(
                        flex: 3,
                        child: Text(
                          '${house.name}, ${house.location}',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Rating with smaller flex to ensure it doesn't get squeezed
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: isSmallScreen ? 16 : 18
                            ),
                            const SizedBox(width: 2),
                            Text(
                              house.rating.toString(),
                              style: TextStyle(
                                fontSize: isSmallScreen ? 12 : 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Spacing that adapts to screen size
                  SizedBox(height: isSmallScreen ? 2.0 : 4.0),

                  // Distance (if available)
                  if (house.distance != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Row(
                        children: [
                          Icon(
                              Icons.location_on,
                              color: Colors.grey[400],
                              size: isSmallScreen ? 14 : 16
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${house.distance} km',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 12 : 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Adaptive spacing
                  SizedBox(height: isSmallScreen ? 2.0 : 4.0),

                  // Price with responsive font size
                  Text(
                    '\$${house.price.toInt()}/Person',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 12 : 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}