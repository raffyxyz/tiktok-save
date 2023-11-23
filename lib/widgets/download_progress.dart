import 'package:flutter/material.dart';

class DownloadProgress extends StatelessWidget {
  final double progress;

  const DownloadProgress({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: LinearProgressIndicator(
        value: progress / 100,
      ),
    );
  }
}
