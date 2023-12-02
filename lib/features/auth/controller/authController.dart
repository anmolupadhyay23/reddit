import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/features/auth/repository/auth_repository.dart';

import '../../../core/utils.dart';
import '../../../models/user_model.dart';

/*
Using provider (riverpod) for authcontroller will help us
We will not have to write the following code to use AuthController:
  AuthController authController=AuthController();
  authController.signInWithGoogle()

 */

// Provider need to be used globally - Cannot be declared in a class
final authControllerProvider=StateNotifierProvider<AuthController,bool>((ref) => AuthController(authRepository: ref.watch(authRepositoryProvider), ref: ref));

// We can change the values given in State Provider later on
final userProvider=StateProvider<UserModel?>((ref) => null);

final authStateChangeProvider=StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider=StreamProvider.family((ref, String uid){
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool>{
  final AuthRepository _authRepository;

  final Ref _ref;

  AuthController({
    required AuthRepository authRepository,
    required Ref ref
}): _authRepository=authRepository,
        _ref=ref,
        super(false); // for loading phase

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  void signInWithGoogle(BuildContext context) async {
    state=true;
    final user=await _authRepository.signInWithGoogle();
    state=false;
    user.fold(
            (l) => showSnackBar(context, l.message),
            (userModel) => _ref.read(userProvider.notifier).update((state) => userModel)
    ); // l is failure, r is success
  }

  Stream<UserModel> getUserData(String uid){
    return _authRepository.getUserData(uid);
  }

}