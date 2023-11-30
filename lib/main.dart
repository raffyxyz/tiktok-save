import 'package:downloader_app/models/History.dart';
import 'package:downloader_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryAdapter());
  await Hive.openBox("historyBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      // brightness: MediaQuery.platformBrightnessOf(context),
      seedColor: Colors.purple.shade400,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tiktok Save',
      theme: ThemeData(
        colorScheme: colorScheme,
        fontFamily: GoogleFonts.quicksand().fontFamily,
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
