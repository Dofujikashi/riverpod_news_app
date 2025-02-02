import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_news/constants.dart';
import 'package:riverpod_news/database/entitiy/search_history.dart';
import 'package:riverpod_news/main.dart';
import 'package:riverpod_news/states.dart';
import 'package:riverpod_news/utility.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late StreamSubscription searchHistorySubscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    searchHistorySubscription = appDatabase.searchHistoryDao.streamSearchHistory().listen(
      (event) {
        ref.read(searchHistoryListProvider.notifier).state = event;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchHistoryList = ref.watch(searchHistoryListProvider);

    Widget searchButton = FilledButton.tonalIcon(
      onPressed: () async {
        if (kSearchController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You need to enter something...')));
        } else {
          kSearchController.closeView(null);
          await appDatabase.searchHistoryDao.insertSearchHistory(
            SearchHistory(id: null, searchQuery: kSearchController.text),
          );
          Navigator.of(context).push(getPageRoute(false));
        }
      },
      label: Text('Search'),
    );

    Widget clearButton = IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        kSearchController.clear();
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Riverpod News'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width / 6),
          child: Column(
            spacing: 12,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'RiverPod News Search',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SearchAnchor.bar(
                searchController: kSearchController,
                barHintText: 'Search news...',
                isFullScreen: false,
                barTrailing: [clearButton, searchButton],
                viewTrailing: [clearButton, searchButton],
                suggestionsBuilder: (context, controller) {
                  return List<ListTile>.generate(
                    searchHistoryList.length,
                    (int index) {
                      final SearchHistory searchHistory = searchHistoryList[index];

                      return ListTile(
                        title: Text(searchHistory.searchQuery),
                        onTap: () {
                          controller.closeView(searchHistory.searchQuery);
                          Navigator.of(context).push(getPageRoute(true));
                        },
                        trailing: TextButton(
                          child: Text('Delete'),
                          onPressed: () async {
                            await appDatabase.newsDao.clearNewsFromQuery(searchHistory.searchQuery);
                            await appDatabase.searchHistoryDao.deleteSearchHistory(searchHistory);
                            controller.closeView(null);
                            controller.clear();
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchHistorySubscription.cancel();
    super.dispose();
  }
}
