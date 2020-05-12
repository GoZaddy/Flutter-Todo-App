import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/src/core/error/exceptions.dart';
import 'package:todo_app/src/core/user/user.dart';
import 'package:todo_app/src/features/todo_manager_features/data/datasources/auth_service.dart';

import '../../../../core/error/failure.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthService authService;

  AuthRepositoryImpl(this.authService);
  @override
  Future<Either<Failure, FirebaseUser>> signInWithGoogle() async{
    try{
      final user = await authService.googleSignIn();
      return Right(user);
    }
    on AuthException{
      return Left(AuthFailure());
    }

    on NoNetworkException{
      return Left(NoNetworkFailure());
    }
    
  }

  @override
  Future<void> signOut() async{
    await authService.signOut();
  }

  @override
  Future<User> getUser() async{
    return authService.getCurrentUser();
  }

  @override
  Future<bool> isSignedIn() {
    return authService.isSignedIn();
  }

}