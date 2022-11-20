import 'package:expenses/data/providers/database_provider.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";

class UserProvider {
  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) throw FirebaseAuthException;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<void> signOut() async {
    GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }

  static Future<void> deleteAccount() async {
    DataBaseProvider.collection.get().then((value) {
      for (var element in value.docs) {
        element.reference.delete();
      }
    });

    signOut();
    FirebaseAuth.instance.currentUser!.delete();
  }
}
