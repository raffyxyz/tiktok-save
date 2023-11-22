import 'package:downloader_app/widgets/steps.dart';
import 'package:flutter/material.dart';

class GuideWidget extends StatelessWidget {
  const GuideWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "How to download?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5.0,
            ),
            const Steps(
              no: "1",
              message:
                  "Open tiktok app and find the video that you want to download, and click on share.",
            ),
            Image.asset("assets/step_1.png"),
            const SizedBox(
              height: 8.0,
            ),
            const Steps(
              no: "2",
              message: "Click on copy link and close the tiktok app.",
            ),
            Image.asset("assets/step_2.png"),
            const SizedBox(
              height: 8.0,
            ),
            const Steps(
              no: "3",
              message:
                  "Open Tiktok Save app and paste the tiktok video link you copied.",
            ),
            Image.asset("assets/step_3.png"),
            const SizedBox(
              height: 8.0,
            ),
            const Steps(
              no: "4",
              message: "Wait for the application to fetch the video info.",
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Steps(
              no: "5",
              message: "Click the download button to start downloading.",
            ),
            Image.asset("assets/step_5.png"),
          ],
        ),
      ),
    );
  }
}
