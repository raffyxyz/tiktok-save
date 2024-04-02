import 'package:downloader_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class Steps extends StatelessWidget {
  final String no;
  final String message;

  const Steps({super.key, required this.no, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 20.0,
          height: 20.0,
          decoration: const BoxDecoration(
            // color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              no,
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
