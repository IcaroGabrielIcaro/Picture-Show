import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FeedPostCard extends StatefulWidget {
  const FeedPostCard({super.key});

  @override
  State<FeedPostCard> createState() => _FeedPostCardState();
}

class _FeedPostCardState extends State<FeedPostCard> {

  bool isLiked = false;
  int likes = 6;

  void toggleLike() {

    setState(() {

      if (isLiked) {
        likes--;
      } else {
        likes++;
      }

      isLiked = !isLiked;

    });

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              InkWell(
                onTap: () {
                  context.push('/perfil');
                },
                borderRadius: BorderRadius.circular(12),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        'https://sm.ign.com/t/ign_pk/feature/t/the-15-bes/the-15-best-nicolas-cage-movies_rquu.1280.jpg',
                      ),
                    ),

                    const SizedBox(width: 10),

                    const Text(
                      'Nicolas Cage',
                      style: TextStyle(
                        fontFamily: 'JosefinSlab',
                        fontSize: 20,
                        color: Color(0xFF3C3535),
                      ),
                    )
                  ],
                ),
              ),

              const Text(
                'Há 3 horas',
                style: TextStyle(
                  fontFamily: 'JosefinSlab',
                  fontSize: 14,
                  color: Color(0xFF3C3535),
                ),
              ),

            ],
          ),

          const SizedBox(height: 10),

          GestureDetector(
            onDoubleTap: toggleLike,

            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://th.bing.com/th/id/R.a6bcea7c182c9f107d177b139a2df09a?rik=yqofBYM3m%2bphTw&riu=http%3a%2f%2fcuriosando708090.altervista.org%2fwp-content%2fuploads%2f2012%2f07%2fevanescence-copertina.jpg&ehk=lx5gNfArFuPftBIXVKQua%2bMgbIOnR8OoOvwcgeoVApc%3d&risl=&pid=ImgRaw&r=0',
                height: 400,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 10),

              Row(
                children: [

                  GestureDetector(
                    onTap: toggleLike,

                    child: Icon(
                      isLiked
                          ? Icons.favorite
                          : Icons.favorite_border,

                      color: isLiked
                          ? const Color(0xFF3C3535)
                          : const Color(0xFF3C3535),
                    ),
                  ),

                  const SizedBox(width: 6),

                  Transform.translate(
                    offset: const Offset(0, 1),

                    child: Text(
                      '$likes',
                      style: const TextStyle(
                        fontFamily: 'JosefinSlab',
                        fontSize: 18,
                        color: Color(0xFF3C3535),
                      ),
                    ),
                  )

                ],
              ),

              const SizedBox(height: 8),

              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'JosefinSlab',
                    fontSize: 16,
                    color: Color(0xFF3C3535),
                  ),
                  children: [
                    TextSpan(
                      text: 'Nicolas Cage ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Pense numa banda de caba macho',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}