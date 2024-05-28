import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stride_up/core/errors/failures.dart';
import 'package:stride_up/core/utils/typedefs.dart';
import 'package:stride_up/models/user.dart';

final _firebase = FirebaseAuth.instance;

class AuthRepository {
  const AuthRepository();

  ResultFuture<void> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _firebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return const Right(null);
    } catch (e) {
      return Left(
        ServerFailure(
          message: e.toString(),
          statusCode: 500,
        ),
      );
    }
  }
}
