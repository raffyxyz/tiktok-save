import 'package:downloader_app/api/tiktok_api.dart';
import 'package:downloader_app/models/Tiktok.dart';
import 'package:downloader_app/widgets/home/guide_widget.dart';
import 'package:downloader_app/widgets/home/result.dart';
import 'package:downloader_app/widgets/steps.dart';
import 'package:flutter/material.dart';
import 'package:downloader_app/widgets/text_field.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final tiktokLinkController = TextEditingController();
  bool isValidUrl = false;
  late final TiktokApiClient tiktokApiClient;
  late Future<Tiktok?> tiktokInfo;

  @override
  void initState() {
    super.initState();

    tiktokApiClient = TiktokApiClient(apiUrl: '');
    tiktokInfo = tiktokApiClient.fetchTiktokInfo();
  }

  @override
  void dispose() {
    tiktokLinkController.dispose();
    super.dispose();
  }

  bool isValidTiktokLink(String url) {
    RegExp tiktokUrlRegex =
        RegExp(r'https:\/\/(www\.|vm\.|vt\.)?tiktok\.com\/.*');

    return tiktokUrlRegex.hasMatch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextField(
            controller: tiktokLinkController,
            hintText: "Paste tiktok video link here",
            obscureText: false,
            icon: const Icon(Icons.link_outlined),
            borderRadius: 5.0,
            onChange: (value) {
              if (isValidTiktokLink(value)) {
                setState(() {
                  tiktokApiClient.apiUrl = value;
                  tiktokInfo = tiktokApiClient.fetchTiktokInfo();
                });
              }
            },
          ),
          const SizedBox(
            height: 30.0,
          ),
          FutureBuilder<Tiktok?>(
            future: tiktokInfo,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                // Final check if.
                return snapshot.data!.data == null
                    ? const Center(
                        child: Text("No video data found."),
                      )
                    : Result(
                        cover: "${snapshot.data!.data?.originCover}",
                        author: "${snapshot.data!.data?.author?.nickname}",
                        title: "${snapshot.data!.data?.title}",
                        play: "${snapshot.data!.data?.play}",
                        id: "${snapshot.data!.data?.id}",
                      );
              } else {
                return GuideWidget();
              }
            },
          ),
        ],
      ),
    );
  }
}
