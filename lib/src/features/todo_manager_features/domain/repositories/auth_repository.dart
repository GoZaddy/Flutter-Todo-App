import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/src/core/error/failure.dart';
import 'package:todo_app/src/core/user/user.dart';

abstract class AuthRepository{
  Future<Either<Failure,FirebaseUser>> signInWithGoogle();
  Future  signOut();
  Future<bool> isSignedIn();
  Future<User> getUser();
}