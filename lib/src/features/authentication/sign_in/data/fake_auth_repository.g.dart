// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fake_auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fakeAuthRepositoryHash() =>
    r'f93aaa2342f0a2d0492b440c29af278e957d6f46';

/// general auth repository provider
///
/// Copied from [fakeAuthRepository].
@ProviderFor(fakeAuthRepository)
final fakeAuthRepositoryProvider = Provider<FakeAuthRepository>.internal(
  fakeAuthRepository,
  name: r'fakeAuthRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fakeAuthRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FakeAuthRepositoryRef = ProviderRef<FakeAuthRepository>;
String _$dataHash() => r'2bf2a25c1d456f8ec9cb5879a59a60685e4c43b2';

/// future provider for fetching data once
///
/// Copied from [data].
@ProviderFor(data)
final dataProvider = AutoDisposeFutureProvider<String>.internal(
  data,
  name: r'dataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DataRef = AutoDisposeFutureProviderRef<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
