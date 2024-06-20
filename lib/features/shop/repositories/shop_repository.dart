import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stride_up/core/errors/failures.dart';
import 'package:stride_up/core/utils/typedefs.dart';

final _firebase = FirebaseAuth.instance;

class ShopRepository {
  const ShopRepository();

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
}
