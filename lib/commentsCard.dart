// Widget for comments sheet
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/constantes.dart' as con;

class CommentsSheet extends StatefulWidget {
  final ScrollController scrollController;

  const CommentsSheet({
    super.key,
    required this.scrollController,
  });

  @override
  State<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<CommentsSheet> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Handle and title
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Comments (137)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Comments list
        Expanded(
          child: ListView.builder(
            controller: widget.scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: 10, // Example comment count
            itemBuilder: (context, index) {
              return CommentItem(
                username: 'User ${index + 1}',
                comment: 'This is a sample comment. It looks like a beautiful place to visit!',
                timeAgo: '${index + 1}h ago',
                likes: index * 5,
              );
            },
          ),
        ),

        // Comment input
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                // User avatar
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage('images/profile.png'),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: con.rosa,
                      width: 1,
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Comment input field
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    maxLines: null,
                  ),
                ),
                const SizedBox(width: 8),

                // Send button
                IconButton(
                  icon: Icon(Icons.send, color: con.rosa),
                  onPressed: () {
                    if (_commentController.text.isNotEmpty) {
                      // Add comment logic here
                      _commentController.clear();
                      FocusScope.of(context).unfocus();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Widget for a single comment
class CommentItem extends StatelessWidget {
  final String username;
  final String comment;
  final String timeAgo;
  final int likes;

  const CommentItem({
    super.key,
    required this.username,
    required this.comment,
    required this.timeAgo,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User avatar
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            child: const Center(
              child: Icon(Icons.person, size: 20, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 12),

          // Comment content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username and time
                Row(
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      timeAgo,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Comment text
                Text(
                  comment,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),

                // Like and reply
                Row(
                  children: [
                    Text(
                      'Like',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Reply',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (likes > 0) ...[
                      const Spacer(),
                      Icon(
                        Icons.favorite,
                        color: con.rosa,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        likes.toString(),
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for comment button
class CommentButton extends StatelessWidget {
  final int count;
  final double iconSize;
  final VoidCallback onTap;

  const CommentButton({
    super.key,
    required this.count,
    this.iconSize = 24,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(iconSize),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(iconSize * 0.3),
        child: Row(
          children: [
            Icon(
              Icons.chat_bubble_outline,
              color: Colors.grey,
              size: iconSize,
            ),
            const SizedBox(width: 4),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: iconSize * 0.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}