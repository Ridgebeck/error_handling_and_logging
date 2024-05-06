import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../exceptions/app_exception.dart';
import 'auth_repository.dart';

part 'fake_auth_repository.g.dart';

class FakeAuthRepository implements AuthRepository {
  /// fake method to test error handlers
  @override
  Future<void> signInWithEmailAndPassword(bool success) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (success) {
      print('signed in');
      return;
    }

    final a = null![1]; // example of throwing an unexpected error
    throw WeakPasswordException(); // example of throwing a defined exception
  }

  /// fake method to test error handlers on futures
  /// also shows usage of AsyncValue widget
  @override
  Future<String> loadData() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    //throw WeakPasswordException(); //example of throwing a defined exception
    return 'data';
  }

  /// fake method to test async errors
  @override
  Future<void> throwAnError() async {
    final myList = [1, 2, 3];
    await Future.delayed(const Duration(milliseconds: 1500));
    // create an error (index out of range)
    final myValue = myList[5];
    return;
  }

  /// fake method to test error handlers on streams
  /// also shows usage of AsyncValue widget
  @override
  Stream<String> watchData() {
    StreamController<String> controller = StreamController<String>();

    // Simulating asynchronous data emission
    Future<void>.delayed(const Duration(milliseconds: 1500), () {
      controller.add('data');
      controller.close(); // Close the stream after adding data
    });

    return controller.stream;
  }
}

/// general auth repository provider
@Riverpod(keepAlive: true)
FakeAuthRepository fakeAuthRepository(FakeAuthRepositoryRef ref) {
  return FakeAuthRepository();
}

/// future provider for fetching data once
@riverpod
Future<String> data(DataRef ref) async {
  return await ref.read(fakeAuthRepositoryProvider).loadData();
}
