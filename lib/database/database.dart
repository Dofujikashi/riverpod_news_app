import 'dart:async';

import 'package:floor/floor.dart';
import 'package:riverpod_news_app/database/dao/news_dao.dart';
import 'package:riverpod_news_app/database/dao/search_history_dao.dart';
import 'package:riverpod_news_app/database/entitiy/news.dart';
import 'package:riverpod_news_app/database/entitiy/search_history.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part '../generated/database/database.g.dart';

@Database(
  version: 1,
  entities: [
    SearchHistory,
    News,
  ],
)
abstract class AppDatabase extends FloorDatabase {
  SearchHistoryDao get searchHistoryDao;
  NewsDao get newsDao;
}
