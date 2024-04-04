import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VideoInfoCard extends StatelessWidget {
  final String cover;
  final String author;
  final String title;
  final List<Widget> children;

  const VideoInfoCard({
    super.key,
    required this.cover,
    required this.author,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Card.filled(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: CachedNetworkImage(
                                imageUrl: cover,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                author,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                title.length > 65
                                    ? title.substring(0, 65)
                                    : title,
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ...children,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
