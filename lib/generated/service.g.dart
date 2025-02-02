// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$newsProviderHash() => r'29889348dff84c03ab55967d55cf4fc6a75be258';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [newsProvider].
@ProviderFor(newsProvider)
const newsProviderProvider = NewsProviderFamily();

/// See also [newsProvider].
class NewsProviderFamily extends Family<AsyncValue<void>> {
  /// See also [newsProvider].
  const NewsProviderFamily();

  /// See also [newsProvider].
  NewsProviderProvider call(
    String query,
  ) {
    return NewsProviderProvider(
      query,
    );
  }

  @override
  NewsProviderProvider getProviderOverride(
    covariant NewsProviderProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'newsProviderProvider';
}

/// See also [newsProvider].
class NewsProviderProvider extends AutoDisposeFutureProvider<void> {
  /// See also [newsProvider].
  NewsProviderProvider(
    String query,
  ) : this._internal(
          (ref) => newsProvider(
            ref as NewsProviderRef,
            query,
          ),
          from: newsProviderProvider,
          name: r'newsProviderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$newsProviderHash,
          dependencies: NewsProviderFamily._dependencies,
          allTransitiveDependencies:
              NewsProviderFamily._allTransitiveDependencies,
          query: query,
        );

  NewsProviderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<void> Function(NewsProviderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NewsProviderProvider._internal(
        (ref) => create(ref as NewsProviderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _NewsProviderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NewsProviderProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin NewsProviderRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `query` of this provider.
  String get query;
}

class _NewsProviderProviderElement
    extends AutoDisposeFutureProviderElement<void> with NewsProviderRef {
  _NewsProviderProviderElement(super.provider);

  @override
  String get query => (origin as NewsProviderProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
