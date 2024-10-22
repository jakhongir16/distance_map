import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

class AuthRepository {
   final FirebaseAuth _firebaseAuth = GetIt.I<FirebaseAuth>();

   AuthRepository();

   Future<User?> signIn(String email, String password) async {
    try{
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
       email: email,
       password: password
       );

       return result.user;

    } catch (e) {
      throw Exception("Failed to Sign In: $e");
    }
   }

   Future<User?> signUp(String email, String password) async {
    try {
       UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password
        );


        return result.user;
    } catch (e) {
      throw Exception("Failed to Sign Up : $e");
    }
   }  

   Future<void> resetPassword(String email) async {
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
     throw Exception("Failed to send password reset: $e");
    }
   }

   Future<void> signOut() async {
    await _firebaseAuth.signOut();
   }


}