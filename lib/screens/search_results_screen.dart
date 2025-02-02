import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_news/constants.dart';
import 'package:riverpod_news/main.dart';
import 'package:riverpod_news/service.dart';
import 'package:riverpod_news/states.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class SearchResultsScreen extends ConsumerStatefulWidget {
  final bool isComingFromSearchHistory;

  const SearchResultsScreen({super.key, required this.isComingFromSearchHistory});

  @override
  ConsumerState<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends ConsumerState<SearchResultsScreen> {
  late StreamSubscription newsSubscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    newsSubscription = appDatabase.newsDao.streamNewsFromQuery(kSearchController.text).listen(
      (event) {
        ref.read(newsListProvider.notifier).state = event;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<void>? news;

    if (!widget.isComingFromSearchHistory) {
      news = ref.watch(newsProviderProvider(kSearchController.text));
    }

    final newsList = ref.watch(newsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results: ${kSearchController.text}'),
      ),
      body: CustomScrollView(
        slivers: [
          widget.isComingFromSearchHistory
              ? SliverList.separated(
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    final news = newsList[index];

                    return Column(
                      children: [
                        ListTile(
                          title: Text(news.title),
                          subtitle: Text('${news.author ?? 'Unknown Author'}, ${news.source}'),
                          onTap: () {
                            print(news.url);
                            url_launcher.launchUrl(Uri.parse(news.url));
                          },
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                )
              : news!.when(
                  data: (data) {
                    return SliverList.separated(
                      itemCount: newsList.length,
                      itemBuilder: (context, index) {
                        final news = newsList[index];

                        return Column(
                          children: [
                            ListTile(
                              title: Text(news.title),
                              subtitle: Text('${news.author ?? 'Unknown Author'}, ${news.source}'),
                              onTap: () {
                                print(news.url);
                                url_launcher.launchUrl(Uri.parse(news.url));
                              },
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 16),
                    );
                  },
                  error: (error, stackTrace) {
                    return SliverFillRemaining(
                      child: Column(
                        children: [
                          Expanded(child: SizedBox()),
                          Text('Something went wrong'),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                    );
                  },
                  loading: () {
                    return SliverFillRemaining(
                      child: Column(
                        children: [
                          Expanded(child: SizedBox()),
                          CircularProgressIndicator(),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    newsSubscription.cancel();
    super.dispose();
  }
}
