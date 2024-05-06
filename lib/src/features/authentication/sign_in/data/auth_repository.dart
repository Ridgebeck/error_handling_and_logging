import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

/// abstract class to define what the auth repository should do
abstract class AuthRepository {
  Future<void> signInWithEmailAndPassword(bool success);

  Future<String> loadData();

  Future<void> throwAnError();

  Stream<String> watchData();
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  throw UnimplementedError();
}
