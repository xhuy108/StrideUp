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
      final shoesList = res.docs.map((doc) => Shoes.fromJson(doc)).toList();

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_firebase.currentUser!.uid)
          .get();
      final userShoes = List<String>.from(userDoc['shoes']);

      final shoesListFiltered =
          shoesList.where((shoe) => !userShoes.contains(shoe.id)).toList();

      return Right(shoesListFiltered);
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
