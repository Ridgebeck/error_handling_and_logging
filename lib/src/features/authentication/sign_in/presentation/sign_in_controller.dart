import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/fake_auth_repository.dart';

part 'sign_in_controller.g.dart';

@riverpod
class SignInController extends _$SignInController {
  // override the [build] method to return a [FutureOr]
  @override
  Future<bool> build() async {
    // return a value (or do nothing if the return type is void)
    return false;
  }

  /// guarded execution of the sign in method
  Future<void> signInWithEmailAndPassword(bool success) async {
    // read the repository using ref
    final authRepository = ref.read(fakeAuthRepositoryProvider);
    // set state to loading
    state = const AsyncLoading();
    // try to sign in (guarded) and update state (data or error)
    try {
      await authRepository.signInWithEmailAndPassword(success);
      state = const AsyncData(true);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
    // state = await AsyncValue.guard(() => authRepository.signInWithEmailAndPassword(success));
  }
}
