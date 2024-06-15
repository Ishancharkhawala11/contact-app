import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class authService {
//create new account
  Future<String> createAccountWithEmail(String email, String Password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: Password);
      return "Account Created";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  //Log in
  Future<String> LoginWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return "LogIn Successful";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }
  //Log out
  Future Logout()async{
    await FirebaseAuth.instance.signOut();
  }
  //checking signin or not
  Future<bool> isLogIn() async{
    var user=FirebaseAuth.instance.currentUser;
    return user!=null;
  }
  //google login
Future<String> ContinueGoogle()async{
    try{
      final GoogleSignInAccount? googleUser=await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth=await googleUser!.authentication;
      final creds=GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken
      );
      await FirebaseAuth.instance.signInWithCredential(creds);
      return "Google Login Successful";
    }
 on FirebaseAuthException  catch(e){
   return e.message.toString();
    }
}
}
