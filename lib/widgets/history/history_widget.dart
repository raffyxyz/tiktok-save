import 'package:downloader_app/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({super.key});

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  late final Box historyBox;

  @override
  void initState() {
    super.initState();
    historyBox = Hive.box('historyBox');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: historyBox.listenable(),
              builder: (context, Box box, widget) {
                if (box.isEmpty) {
                  return const Center(child: Text("No history."));
                } else {
                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      var currentBox = box;
                      var historyData =
                          currentBox.getAt(box.length - 1 - index)!;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: MyCard(
                          cover: historyData.cover,
                          author: historyData.author,
                          title: historyData.title,
                          filePath: historyData.filePath,
                          index: box.length - 1 - index,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
