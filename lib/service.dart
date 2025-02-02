import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_news_app/constants.dart';
import 'package:riverpod_news_app/database/entitiy/news.dart';
import 'package:riverpod_news_app/main.dart';

part 'generated/service.g.dart';

@riverpod
Future<void> newsProvider(Ref ref, String query) async {
  final response = await http.get(
      Uri.https(
        kAuthority,
        kBasePath,
        {
          'q': kSearchController.text,
        },
      ),
      headers: {
        'X-Api-Key': kApiKey,
      });

  if (response.statusCode == 200) {
    final Map decodedResult = json.decode(response.body);
    final List data = decodedResult['articles'];
    await appDatabase.newsDao.insertNews(
      data
          .map((news) => News(
                id: null,
                myQuery: query,
                source: news['source']['name'],
                author: news['author'],
                title: news['title'],
                url: news['url'],
              ))
          .toList(),
    );
  } else {
    throw Exception('Failed to load news');
  }
}
