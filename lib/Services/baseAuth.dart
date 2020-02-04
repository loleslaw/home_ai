import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:HomeAI/models/appUser.dart';

import '../main.dart';

abstract class BaseAuth {
  Future<FirebaseUser> signIn(String email, String password);
  Future<AppUser> signUp(String email, String password);
  Future<AppUser> getCurrentUser();
  Future<void> signOut();
 // AppUser getAppUser(FirebaseUser fbUser);
}




//final usersReference = FirebaseDatabase.instance.reference().child('userData');

class Auth implements BaseAuth {
  Future<AppUser> getAppUser(FirebaseUser fbUser) async {
  
  if (fbUser != null) {
    return AppUser(
      email: fbUser.email,
      uid: fbUser.uid,
      name: fbUser.displayName
      );
  } else {
    return null;
  }
  

  /*
        if (fbUser != null) {
         usersReference.child(fbUser.uid).once().then((DataSnapshot sp) async {
            print('data ${sp.value}');
            AppUser _user = AppUser(
              email: fbUser.email!= null ? fbUser.email : '',
              name: fbUser.displayName != null ? fbUser.displayName : '',
              phone: sp.value["phoneNo"]!= null ? sp.value["phoneNo"]:'',
              photoURL: fbUser.photoUrl!=null ? fbUser.photoUrl : '',
              password: ''
             );
             print('user $_user');
             user = _user;
             return _user;
         }).catchError((error) {
           print('Error getAppUser $error');
           return AppUser();
         });
      }
  */

}
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> signIn(String email, String password) async {
    // FirebaseUseru
      AppUser _user;
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      
      return result.user;
  }
  Future<AppUser> signUp(String email, String password) async {
    // FirebaseUser
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    if (result.user != null) {

    //  usersReference.child(result.user.uid).set({"phoneNo":""}); 
    }

    return await getAppUser(result.user);
  }

  Future<AppUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    fbUser = user;
    return await getAppUser(fbUser);
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<AppUser> updateUserData({String displayName, String email, String phoneNumber, 
    String password, String photoUrl}) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    UserUpdateInfo info = UserUpdateInfo();
    info.displayName = displayName;
    info.photoUrl = photoUrl;

    user.updateProfile(info);

    if (password!='') {
      user.updatePassword(password);
    }
    
    if (email!= '') {
      user.updateEmail(email);
    }

    if (phoneNumber!= '') {
        if (user != null) {
      //    usersReference.child(user.uid).set({"phoneNo":phoneNumber}); 
        }
    }
    fbUser = await _firebaseAuth.currentUser();
    return getAppUser(fbUser);
  }

  Future<void> resetPassword({String userEmail}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: userEmail);
  }
  

}

