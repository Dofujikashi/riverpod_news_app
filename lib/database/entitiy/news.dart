import 'package:floor/floor.dart';

@Entity()
class News {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String myQuery;
  final String source;
  final String? author;
  final String title;
  final String url;

  News({
    required this.id,
    required this.myQuery,
    required this.source,
    required this.author,
    required this.title,
    required this.url,
  });
}
