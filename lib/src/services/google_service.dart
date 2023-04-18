import 'package:cine_app/src/services/login_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  static Future signInWithGoogle() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      final LoginService loginService = LoginService();
      if (account != null) {
        loginService.signInWithGoogle(account);
      }
      return account;
    } catch (e) {
      return null;
    }
  }

  static Future signOutWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      await _googleSignIn.disconnect();
    } catch (e) {
      return null;
    }
  }
}
