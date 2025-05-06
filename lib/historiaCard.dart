import 'package:flutter/material.dart';

class TravelCategory extends StatelessWidget {
  final String image;
  final String storyImage;
  final String name;
  final Color color;
  final double size;

  const TravelCategory({
    super.key,
    required this.image,
    required this.name,
    required this.color,
    required this.size,
    required this.storyImage,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = size * 0.18;

    return GestureDetector(
      onTap: () {
        // Show story view when tapped
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) {
              return StoryView(
                image: storyImage,
                username: name,
                color: color,
              );
            },
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: size * 0.2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Imagen circular con borde - Fixed size
            Container(
              width: size,
              height: size,
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
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.error, color: Colors.red, size: 16),
                          ),
                        );
                      },
                    )
                ),
              ),
            ),
            SizedBox(height: size * 0.1),
            // Nombre de la categoría - Responsive font size
            Text(
              name,
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryView extends StatefulWidget {
  final String image;
  final String username;
  final Color color;
  final Duration storyDuration;

  const StoryView({
    super.key,
    required this.image,
    required this.username,
    required this.color,
    this.storyDuration = const Duration(seconds: 5),
  });

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();

    // Initialize progress controller
    _progressController = AnimationController(
      vsync: this,
      duration: widget.storyDuration,
    );

    // Start the animation
    _progressController.forward();

    // Close the story when animation completes
    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
      if (_isPaused) {
        _progressController.stop();
      } else {
        _progressController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _togglePause,
        onLongPress: _togglePause,
        onVerticalDragEnd: (_) => Navigator.of(context).pop(),
        child: Stack(
          children: [
            // Full screen image
            Center(
              child: Image.asset(
                widget.image,
                fit: BoxFit.contain,
                height: double.infinity,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[900],
                    child: const Center(
                      child: Icon(Icons.error, color: Colors.white, size: 50),
                    ),
                  );
                },
              ),
            ),

            // Top bar with progress indicator
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: Row(
                      children: [
                        // Progress bar
                        Expanded(
                          child: AnimatedBuilder(
                            animation: _progressController,
                            builder: (context, child) {
                              return LinearProgressIndicator(
                                value: _progressController.value,
                                backgroundColor: Colors.grey.withOpacity(0.5),
                                valueColor: AlwaysStoppedAnimation<Color>(widget.color),
                                minHeight: 2,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Username
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: widget.color,
                          child: Text(
                            widget.username.isNotEmpty ? widget.username[0].toUpperCase() : '?',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.username,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Pause indicator
            if (_isPaused)
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}