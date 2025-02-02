import 'package:floor/floor.dart';
import 'package:riverpod_news_app/database/entitiy/news.dart';

@dao
abstract class NewsDao {
  @Query('SELECT * FROM News WHERE myQuery = :myQuery')
  Stream<List<News>> streamNewsFromQuery(String myQuery);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertNews(List<News> newList);

  @Query('DELETE FROM News WHERE myQuery = :myQuery')
  Future<void> clearNewsFromQuery(String myQuery);
}
