import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sayur_widget/core.dart';

class YurGoogle {
//Sign-in
  static Future<UserCredential?> signIn() async {
    try {
      YurLoading(
        loadingStatus: LoadingStatus.show,
        message: "Signing in with Google",
      );
      // Trigger the Google Sign-In process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // The user canceled the sign-in process
        return null;
      }

      // Obtain the authentication details from the Google Sign-In request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential using the obtained authentication details
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
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
    await GoogleSignIn().signOut();
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
