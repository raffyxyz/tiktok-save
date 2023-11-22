import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String cover;
  final String author;
  final String title;

  const MyCard({
    super.key,
    required this.cover,
    required this.author,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        color: Colors.grey.shade100,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: SizedBox(
                width: 80,
                height: 80,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.network(cover),
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    title.length > 65 ? title.substring(0, 65) : title,
                    softWrap: true,
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
