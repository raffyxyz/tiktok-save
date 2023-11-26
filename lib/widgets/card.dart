import 'dart:io';

import 'package:downloader_app/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:open_file_plus/open_file_plus.dart';

class MyCard extends StatefulWidget {
  final String cover;
  final String author;
  final String title;
  final String filePath;
  final int index;

  const MyCard({
    super.key,
    required this.cover,
    required this.author,
    required this.title,
    required this.filePath,
    required this.index,
  });

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  late final Box historyBox;

  @override
  void initState() {
    super.initState();
    historyBox = Hive.box('historyBox');
  }

  void _openVideo(String filepath) async {
    var file = File(widget.filePath);

    if (await file.exists()) {
      await OpenFile.open(widget.filePath);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(child: Text("File doesnt exist.")),
      ));
    }
  }

  void _removeVideo(int index) async {
    try {
      await historyBox.deleteAt(index);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(child: Text("Video removed.")),
      ));
    } catch (e) {
      debugPrint("Error occured: $e");
    }
  }

  void _deleteVideo(String path, int index) async {
    var file = File(path);

    try {
      if (await file.exists()) {
        await file.delete();

        // Also remove from the history
        await historyBox.deleteAt(index);

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Center(child: Text("Video deleted.")),
        ));
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Center(child: Text("File doesnt exist.")),
        ));
      }
    } catch (e) {
      debugPrint("Error deleting file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GestureDetector(
        // onTapDown: (details) => _getTapPosition(details),
        // onLongPress: () => _showContextMenu(context),
        onLongPress: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => Dialog(
            backgroundColor: AppColors.secondaryBgColor,
            shadowColor: AppColors.secondaryBgColor,
            surfaceTintColor: AppColors.secondaryBgColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        _openVideo(widget.filePath);
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.foreGroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: const Text(
                        "Open",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        _removeVideo(widget.index);
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.foreGroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: const Text(
                        "Remove",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        _deleteVideo(widget.filePath, widget.index);
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.foreGroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: const Text(
                        "Delete",
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: const Text('Close'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onTap: () => _openVideo(widget.filePath),
        child: Container(
          color: AppColors.secondaryBgColor,
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
                    child: Image.network(widget.cover),
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
                      widget.author,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.title.length > 65
                          ? widget.title.substring(0, 65)
                          : widget.title,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
