import 'package:downloader_app/models/History.dart';
import 'package:downloader_app/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:hive/hive.dart';

class Result extends StatefulWidget {
  final String cover;
  final String author;
  final String title;
  final String play;
  final String id;

  const Result({
    super.key,
    required this.cover,
    required this.author,
    required this.title,
    required this.play,
    required this.id,
  });

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  late final Box historyBox;
  double? _progress;
  String _status = '';
  bool _isDownloading = false;
  bool _isDownloadFinish = false;

  @override
  void initState() {
    super.initState();
    historyBox = Hive.box("historyBox");
  }

  void _addHistory(String filePath) async {
    History newHistory = History(
        cover: widget.cover,
        author: widget.author,
        title: widget.title,
        filePath: filePath);
    historyBox.add(newHistory);
    debugPrint("Added history");
  }

  void _downloadVideo(String id, String play, BuildContext context) async {
    FileDownloader.downloadFile(
      url: widget.play,
      name: "NoMarkTik-${widget.id}.mp4",
      downloadDestination: DownloadDestinations.publicDownloads,
      notificationType: NotificationType.all,
      onProgress: (name, progress) {
        setState(() {
          _progress = progress;
          _status = 'Downloading: $progress%';
          _isDownloading = true;
        });
      },
      onDownloadCompleted: (path) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Center(child: Text("Download finished.")),
        ));
        setState(() {
          _progress = null;
          _status = 'File downloaded to: $path';
          _isDownloading = false;
          _isDownloadFinish = true;
        });
      },
      onDownloadError: (error) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Center(child: Text("Download failed.")),
        ));
        setState(() {
          _progress = null;
          _status = 'Download error: $error';
          _isDownloading = false;
        });
      },
    ).then((file) {
      _addHistory("${file?.path}");
      debugPrint("file path: ${file?.path}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyCard(cover: widget.cover, author: widget.author, title: widget.title),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     ClipRRect(
        //       borderRadius: BorderRadius.circular(5.0),
        //       child: SizedBox(
        //         width: 80,
        //         height: 90,
        //         child: FittedBox(
        //           fit: BoxFit.cover,
        //           child: Image.network(
        //             widget.cover,
        //           ),
        //         ),
        //       ),
        //     ),
        //     const SizedBox(width: 8),
        //     Expanded(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: <Widget>[
        //           Text(
        //             widget.author,
        //             style: const TextStyle(fontWeight: FontWeight.bold),
        //           ),
        //           Text(
        //             widget.title.length > 65
        //                 ? widget.title.substring(0, 65)
        //                 : widget.title,
        //             softWrap: true,
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        if (_progress != null) ...[
          const SizedBox(
            height: 10.0,
          ),
          LinearProgressIndicator(
            value: _progress! / 100,
          ),
        ],
        if (_status.isNotEmpty) ...[
          const SizedBox(height: 5.0),
          Text(
            _status,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10.0),
          ),
        ],
        const SizedBox(
          height: 10.0,
        ),
        if (!_isDownloadFinish) ...[
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isDownloading
                  ? null
                  : () => _downloadVideo(widget.id, widget.play, context),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                backgroundColor: Colors.purple,
              ),
              child: const Text(
                "Download Video",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
