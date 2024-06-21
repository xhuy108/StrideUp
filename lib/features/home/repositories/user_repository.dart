import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stride_up/core/errors/failures.dart';
import 'package:stride_up/core/utils/typedefs.dart';
import 'package:stride_up/models/shoes.dart';
import 'package:stride_up/models/user.dart' as user_model;

class UserRepository {
  ResultFuture<user_model.User> getUser() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser!.uid;
      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser)
          .get();

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

  ResultFuture<List<Shoes>> fetchUserShoes() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser!.uid;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser)
          .get();

      final user = user_model.User.fromJson(userData.data()!);

      final shoes = await Future.wait(
        user.shoes.map(
          (shoeId) async {
            final shoe = await FirebaseFirestore.instance
                .collection('shoes')
                .doc(shoeId)
                .get();

            return Shoes.fromJson(shoe.data()!);
          },
        ),
      );

      print(shoes.length);

      return Right(shoes);
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
