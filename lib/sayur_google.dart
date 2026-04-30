import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sayur_widget/sayur_core.dart';

class YurGoogle {
  static bool _isGoogleSignInInitialized = false;

  // Initialize GoogleSignIn
  static Future<void> _ensureGoogleSignInInitialized({
    String? clientID,
    String? serverClientID,
  }) async {
    if (!_isGoogleSignInInitialized) {
      try {
        await GoogleSignIn.instance.initialize(
          clientId: clientID,
          serverClientId: serverClientID,
        );
        _isGoogleSignInInitialized = true;
      } catch (e) {
        YurLog(name: "GoogleSignIn", 'Failed to initialize: $e');
      }
    }
  }

//Sign-in
  static Future<UserCredential?> signIn({
    String? clientID,
    String? serverClientID,
  }) async {
    try {
      YurLoading(
        loadingStatus: LoadingStatus.show,
        message: "Signing in with Google",
      );

      // Ensure GoogleSignIn is initialized
      await _ensureGoogleSignInInitialized(
        clientID: clientID,
        serverClientID: serverClientID,
      );

      // Trigger the Google Sign-In process using authenticate()
      final GoogleSignInAccount googleUser =
          await GoogleSignIn.instance.authenticate(
        scopeHint: ['email', 'profile'],
      );

      // Obtain the auth details from the request
      // In v7, authentication is now synchronous
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // Create a new credential using only idToken
      // Firebase only requires idToken for Google Sign-In
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      YurLoading(loadingStatus: LoadingStatus.dismiss);

      return userCredential;
    } catch (error) {
      YurLoading(loadingStatus: LoadingStatus.dismiss);
      // Handle any errors that might occur during the sign-in process
      YurLog(name: "signInWithGoogle", 'Error signing in with Google: $error');
      return null;
    }
  }

//Sign-out
  static Future<void> signOut() async {
    await GoogleSignIn.instance.signOut();
    _isGoogleSignInInitialized = false;
  }

//Check if user is signed in
  static Future<bool> isSignedIn() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    return currentUser != null;
  }

//Get current user
  static Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

//Get current user token
  static Future<String?> getCurrentUserToken() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    return currentUser?.getIdToken();
  }

//Get current user id
  static Future<String?> getCsurrentUserID() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    return currentUser?.uid;
  }
}
