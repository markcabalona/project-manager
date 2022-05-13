import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/domain/usecases/usecase_params.dart';

abstract class Authenticator {
  Future<User> signIn(AuthParams params);
  Future<User> signUp(AuthParams params);
  Future<User> googleSignIn();
  Future<void> signOut();
}
