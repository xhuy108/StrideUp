import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stride_up/core/errors/failures.dart';
import 'package:stride_up/core/utils/typedefs.dart';
import 'package:stride_up/models/user.dart' as user_model;

class UserRepository {
  ResultFuture<user_model.User> getUser() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser!.uid;
      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser)
          .get();

      print(user);

      return Right(user_model.User.fromJson(user.data()!));
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
