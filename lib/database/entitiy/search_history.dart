import 'package:floor/floor.dart';

@Entity()
class SearchHistory {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String searchQuery;

  SearchHistory({
    required this.id,
    required this.searchQuery,
  });
}
