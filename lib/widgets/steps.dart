import 'package:flutter/material.dart';

class Steps extends StatelessWidget {
  final String no;
  final String message;

  const Steps({super.key, required this.no, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20.0,
          height: 20.0,
          decoration: const BoxDecoration(
            color: Colors.purple,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              no,
              style: const TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Text(
            message,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
