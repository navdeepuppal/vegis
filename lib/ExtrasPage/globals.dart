library globals;

import 'package:google_sign_in/google_sign_in.dart';

bool _isLoggedIn = false;
GoogleSignInAccount _userObj;
GoogleSignIn _googleSignIn = GoogleSignIn();

class globals {
  static void set_isLoggedin(bool newValue) {
    _isLoggedIn = newValue;
  }

  static void set_userObj(GoogleSignInAccount newValue) {
    _userObj = newValue;
  }

  static GoogleSignIn get_googleSignIn() {
    return _googleSignIn;
  }
}
