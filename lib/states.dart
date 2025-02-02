import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_news_app/database/entitiy/news.dart';
import 'package:riverpod_news_app/database/entitiy/search_history.dart';

final searchHistoryListProvider = StateProvider<List<SearchHistory>>((ref) => []);
final newsListProvider = StateProvider<List<News>>((ref) => []);
final newsListWidgetProvider = StateProvider<Widget>((ref) => SizedBox());
