import 'package:floor/floor.dart';
import 'package:riverpod_news/database/entitiy/search_history.dart';

@dao
abstract class SearchHistoryDao {
  @Query('SELECT * FROM SearchHistory')
  Stream<List<SearchHistory>> streamSearchHistory();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSearchHistory(SearchHistory searchHistory);

  @delete
  Future<void> deleteSearchHistory(SearchHistory searchHistory);
}
