import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/domain/usecases/usecase_params.dart';
import '../../domain/usecases/send_email_otp.dart';

abstract class Authenticator {
  Future<User> signIn(AuthParams params);
  Future<User> signUp(AuthParams params);
  Future<User> googleSignIn();
  Future<void> signOut();

  Future<User> sendEmailOTP(EmailOTPParams emailOTPParams);
  Future<User> validateEmailOTP(EmailOTPParams emailOTPParams);
}
