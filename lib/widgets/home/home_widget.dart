import 'dart:async';
import 'dart:developer' as developer;

import 'package:downloader_app/api/tiktok_api.dart';
import 'package:downloader_app/models/Tiktok.dart';
import 'package:downloader_app/widgets/home/guide_widget.dart';
import 'package:downloader_app/widgets/home/result.dart';
import 'package:downloader_app/widgets/text_field.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  // Network connection.
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  // Tiktok api request.
  final tiktokLinkController = TextEditingController();
  bool isValidUrl = false;
  late final TiktokApiClient tiktokApiClient;
  late Future<Tiktok?> tiktokInfo;

  @override
  void initState() {
    super.initState();

    tiktokApiClient = TiktokApiClient(apiUrl: '');
    tiktokInfo = tiktokApiClient.fetchTiktokInfo();

    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    tiktokLinkController.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  bool _isConnectionPresent() {
    return _connectionStatus.toString() == "ConnectivityResult.wifi" ||
        _connectionStatus.toString() == "ConnectivityResult.mobile";
  }

  bool _isValidTiktokLink(String url) {
    RegExp tiktokUrlRegex =
        RegExp(r'https:\/\/(www\.|vm\.|vt\.)?tiktok\.com\/.*');

    return tiktokUrlRegex.hasMatch(url);
  }

  void _handleLinkChange(String value) {
    if (_isValidTiktokLink(value)) {
      setState(() {
        tiktokApiClient.apiUrl = value;
        tiktokInfo = tiktokApiClient.fetchTiktokInfo();
      });
    }
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
            readOnly: _isConnectionPresent() ? false : true,
            onChange: (value) => _handleLinkChange(value),
          ),
          const SizedBox(
            height: 20.0,
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
                        title: snapshot.data!.data?.title == null
                            ? ""
                            : "${snapshot.data!.data?.title}",
                        play: "${snapshot.data!.data?.play}",
                        id: "${snapshot.data!.data?.id}",
                      );
              } else {
                return _isConnectionPresent()
                    ? const GuideWidget()
                    : const Center(
                        child: Text("No network."),
                      );
              }
            },
          ),
        ],
      ),
    );
  }
}
