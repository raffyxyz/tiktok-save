import 'dart:async';
import 'dart:developer' as developer;

import 'package:downloader_app/widgets/bottom_navigation.dart';
import 'package:downloader_app/widgets/history/history_widget.dart';
import 'package:downloader_app/widgets/home/home_widget.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  int _selectedPage = 0;
  final _pages = [
    const HomeWidget(),
    const HistoryWidget(),
  ];

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
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

  void setPage(int currentPage) {
    setState(() {
      _selectedPage = currentPage;
    });
  }

  bool _isConnectionPresent() {
    return _connectionStatus.toString() == "ConnectivityResult.wifi" ||
        _connectionStatus.toString() == "ConnectivityResult.mobile";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          "Tiktok Save",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Center(
                    child: Text(
                  "In development.",
                )),
              ));
            },
            icon: const Icon(Icons.settings),
            tooltip: "Settings",
          ),
        ],
      ),
      body: _isConnectionPresent()
          ? IndexedStack(
              index: _selectedPage,
              children: _pages,
            )
          : const Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text("No connection."),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: _isConnectionPresent()
          ? BottomNavigation(
              setPage: setPage,
            )
          : null,
    );
  }
}
