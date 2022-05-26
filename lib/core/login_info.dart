import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'shared_prefs.dart';

class LoginInfo extends ChangeNotifier {
  static LoginInfo? _instance;
  late String? _currentUID;
  LoginInfo._() {
    _isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;
    _currentUID = _prefs.getString('current_uid');
  }

  static LoginInfo get instance => _instance ??= LoginInfo._();

  final _prefs = SharedPrefs.prefs;

  late bool _isLoggedIn;

  bool get isLoggedIn => _isLoggedIn;
  String? get currentUID => _currentUID;

  void login() {
    _isLoggedIn = true;
    _prefs.setBool('isLoggedIn', true);
    _currentUID = FirebaseAuth.instance.currentUser!.uid;
    _prefs.setString('current_uid', _currentUID!);
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _prefs.setBool('isLoggedIn', false);
    _prefs.remove('current_uid');
    _currentUID = null;
    notifyListeners();
  }
}
