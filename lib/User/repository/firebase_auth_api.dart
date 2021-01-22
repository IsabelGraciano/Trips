import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAPI {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<auth.User> signIn() async{
    //es como la pantalla de con que cuenta quieres ingresar?
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    //tomar todos los datos de google, de la cuenta
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    //pasar las redenciales de la cuenta de google al objeto googl de firebase
    auth.UserCredential userCredential = await _auth.signInWithCredential(
      auth.GoogleAuthProvider.credential(idToken: gSA.idToken, accessToken: gSA.accessToken));

    return userCredential.user;
  }

  void signOut() async{
    await _auth.signOut().then((value) => print("Sesión cerrada"));
    googleSignIn.signOut();
    print("Sesiones cerradas");
  }
}