import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static User? get currentUser =>_auth.currentUser;

  static Future<String?> login(String email,String password) async{
    final credential =await _auth.signInWithEmailAndPassword(email: email, password: password);
    return credential.user?.uid;
  }
  static Future<String?> registerUser(String email,String password) async{
    final credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return credential.user?.uid;
  }
  static bool isUserVerified()=> _auth.currentUser?.emailVerified??false;

  static Future<void> sendVerificationMail(){
    return _auth.currentUser!.sendEmailVerification();
  }

  static Future<void> logut(){
    return _auth.signOut();
  }
}