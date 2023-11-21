import 'package:downloader_app/widgets/bottom_navigation.dart';
import 'package:downloader_app/widgets/download_widget.dart';
import 'package:downloader_app/widgets/home/home_widget.dart';

import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPage = 0;

  void setPage(int currentPage) {
    setState(() {
      _selectedPage = currentPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("SaveTok"),
        actions: [
          IconButton(
            onPressed: () {
              debugPrint("Pressed");
            },
            icon: const Icon(Icons.settings),
            tooltip: "Settings",
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        HomeWidget(),
        //Downloads
        const DownloadWidget(),
      ][_selectedPage],
      bottomNavigationBar: BottomNavigation(
        setPage: setPage,
      ),
    );
  }
}
