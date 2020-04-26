import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Stream<FirebaseUser> user; //firebase user
  Stream<Map<String, dynamic>> profile; //custom user data in firestore
  PublishSubject loading = PublishSubject();

  //constructor
  AuthService() {
    user = _auth.onAuthStateChanged;
    

    profile = user.switchMap((FirebaseUser user) {
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

  Future<FirebaseUser> googleSignIn() async {
    loading.add(true);
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    AuthResult result = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken)
    );
    FirebaseUser user =  result.user;
    updateUserData(user); 
    print("signed in " + user.displayName);
    loading.add(false);
    return user;
    
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

  void signOut() {
    _auth.signOut();
  }
}

 