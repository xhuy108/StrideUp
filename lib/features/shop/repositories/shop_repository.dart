import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stride_up/core/errors/failures.dart';
import 'package:stride_up/core/utils/typedefs.dart';
import 'package:stride_up/models/shoes.dart';

final _firebase = FirebaseAuth.instance;

class ShopRepository {
  const ShopRepository();

  ResultFuture<List<Shoes>> fetchShoes() async {
    try {
      final res = await FirebaseFirestore.instance.collection('shoes').get();
      final shoesList =
          res.docs.map((doc) => Shoes.fromJson(doc.data())).toList();

      return Right(shoesList);
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
