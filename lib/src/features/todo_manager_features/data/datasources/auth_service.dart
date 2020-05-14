import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_app/src/core/user/user.dart';

import '../../../../core/error/exceptions.dart' as exception;

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  Stream<Map<String, dynamic>> profile; 

  AuthService() {
    profile = _auth.onAuthStateChanged.switchMap((FirebaseUser user) {
      if (user != null) {
        return _db
            .collection("users")
            .document(user.uid)
            .snapshots()
            .map((snap) => snap.data);
      } else {
        return Stream.empty();
      }
    });
  }

  Stream<User> get user{
    return _auth.onAuthStateChanged.map(getUserFromFirebaseUser);
  } 



  User getUserFromFirebaseUser(FirebaseUser user){
    return user != null ? User.fromFirebaseUser(user): null;
  }

  Future<User> getCurrentUser() async{
    final user = User.fromFirebaseUser(await _auth.currentUser());
    if(user.uid == null){
      return null;
    }
    return user;
  }

  Future<bool> isSignedIn() async{
    final currentUser = await _auth.currentUser();
    return currentUser != null;
  }

  

  Future<FirebaseUser> googleSignIn() async {
    try{
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthResult result = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken)
      );
      FirebaseUser user =  result.user;
      updateUserData(user); 
      
      return user; 
    }
    on PlatformException catch(e){
      if(e.code == 'sign_in_failed'){
        throw AuthException;
      }
      else if(e.code == 'network_error'){
        throw exception.NoNetworkException;
      }
      else{
        print(e);
      }
    }
  }

  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection("users").document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.uid,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
    }
    
  }
}

 