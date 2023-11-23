// ignore: file_names
import 'package:hive/hive.dart';
part 'History.g.dart';

@HiveType(typeId: 1)
class History {
  @HiveField(0)
  final String cover;
  @HiveField(1)
  final String author;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String filePath;

  History({
    required this.cover,
    required this.author,
    required this.title,
    required this.filePath,
  });
}
