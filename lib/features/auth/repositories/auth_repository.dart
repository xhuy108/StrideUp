import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stride_up/core/errors/failures.dart';
import 'package:stride_up/core/utils/typedefs.dart';
import 'package:stride_up/models/user.dart';

final _firebase = FirebaseAuth.instance;

class AuthRepository {
  const AuthRepository();

  ResultFuture<void> signUpWithEmailAndPassword(
    String email,
    String password,
    String username,
    String phoneNumber,
  ) async {
    try {
      final result = await _firebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      FirebaseFirestore.instance.collection('users').doc(result.user!.uid).set({
        'email': email,
        'username': username,
        'phoneNumber': phoneNumber,
      });

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

  ResultFuture<void> logIn(String email, String password) async {
    try {
      final result = await _firebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(
        ServerFailure(
          message: e.message ?? 'An error occurred',
          statusCode: 500,
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          message: e.toString(),
          statusCode: 500,
        ),
      );
    }
  }

  ResultFuture<void> logOut() async {
    try {
      final result = await _firebase.signOut();

      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(
        ServerFailure(
          message: e.message ?? 'An error occurred',
          statusCode: 500,
        ),
      );
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
