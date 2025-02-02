// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../database/database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  SearchHistoryDao? _searchHistoryDaoInstance;

  NewsDao? _newsDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SearchHistory` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `searchQuery` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `News` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `myQuery` TEXT NOT NULL, `source` TEXT NOT NULL, `author` TEXT, `title` TEXT NOT NULL, `url` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  SearchHistoryDao get searchHistoryDao {
    return _searchHistoryDaoInstance ??=
        _$SearchHistoryDao(database, changeListener);
  }

  @override
  NewsDao get newsDao {
    return _newsDaoInstance ??= _$NewsDao(database, changeListener);
  }
}

class _$SearchHistoryDao extends SearchHistoryDao {
  _$SearchHistoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _searchHistoryInsertionAdapter = InsertionAdapter(
            database,
            'SearchHistory',
            (SearchHistory item) => <String, Object?>{
                  'id': item.id,
                  'searchQuery': item.searchQuery
                },
            changeListener),
        _searchHistoryDeletionAdapter = DeletionAdapter(
            database,
            'SearchHistory',
            ['id'],
            (SearchHistory item) => <String, Object?>{
                  'id': item.id,
                  'searchQuery': item.searchQuery
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SearchHistory> _searchHistoryInsertionAdapter;

  final DeletionAdapter<SearchHistory> _searchHistoryDeletionAdapter;

  @override
  Stream<List<SearchHistory>> streamSearchHistory() {
    return _queryAdapter.queryListStream('SELECT * FROM SearchHistory',
        mapper: (Map<String, Object?> row) => SearchHistory(
            id: row['id'] as int?, searchQuery: row['searchQuery'] as String),
        queryableName: 'SearchHistory',
        isView: false);
  }

  @override
  Future<void> insertSearchHistory(SearchHistory searchHistory) async {
    await _searchHistoryInsertionAdapter.insert(
        searchHistory, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteSearchHistory(SearchHistory searchHistory) async {
    await _searchHistoryDeletionAdapter.delete(searchHistory);
  }
}

class _$NewsDao extends NewsDao {
  _$NewsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _newsInsertionAdapter = InsertionAdapter(
            database,
            'News',
            (News item) => <String, Object?>{
                  'id': item.id,
                  'myQuery': item.myQuery,
                  'source': item.source,
                  'author': item.author,
                  'title': item.title,
                  'url': item.url
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<News> _newsInsertionAdapter;

  @override
  Stream<List<News>> streamNewsFromQuery(String myQuery) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM News WHERE myQuery = ?1',
        mapper: (Map<String, Object?> row) => News(
            id: row['id'] as int?,
            myQuery: row['myQuery'] as String,
            source: row['source'] as String,
            author: row['author'] as String?,
            title: row['title'] as String,
            url: row['url'] as String),
        arguments: [myQuery],
        queryableName: 'News',
        isView: false);
  }

  @override
  Future<void> clearNewsFromQuery(String myQuery) async {
    await _queryAdapter.queryNoReturn('DELETE FROM News WHERE myQuery = ?1',
        arguments: [myQuery]);
  }

  @override
  Future<void> insertNews(List<News> newList) async {
    await _newsInsertionAdapter.insertList(newList, OnConflictStrategy.replace);
  }
}
