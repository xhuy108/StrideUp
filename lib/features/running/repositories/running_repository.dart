import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stride_up/core/errors/failures.dart';
import 'package:stride_up/core/utils/typedefs.dart';
import 'package:stride_up/models/running_record.dart';
import 'package:stride_up/models/shoes.dart';
import 'package:stride_up/models/user.dart' as userModel;

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class RunningReporsitory {
  const RunningReporsitory();
  ResultFuture<void> upRunningStatus(
  RunningRecord runningRecord)async{
    try{
      DocumentReference<Map<String, dynamic>> respone = await firestore.collection(RunningRecord.COLLECTION_NAME).add(runningRecord.toJson());
      DocumentSnapshot<Map<String, dynamic>> userData  = await firestore.collection("user").doc(auth.currentUser!.uid).get();
      return const Right(null);
    }
    catch(e){
        return Left(
        ServerFailure(
          message: e.toString(),
          statusCode: 500,
        ),
      );
    }
  }
  ResultFuture<List<RunningRecord>> getAllRunningRecord(String userID) async{
        try{
           List<RunningRecord> listRunningRecord = [];
      final QuerySnapshot<Map<String, dynamic>> response = await firestore.collection(RunningRecord.COLLECTION_NAME).where("userId", isEqualTo: userID).get();
      for(int i =0; i<response.docs.length;i++){
        RunningRecord runningRecord = RunningRecord.fromJson(response.docs[i].data());
        runningRecord.id = response.docs[i].id;
        listRunningRecord.add(runningRecord);
      }
      return Right(listRunningRecord);
    }
    catch(e){
        return Left(
        ServerFailure(
          message: e.toString(),
          statusCode: 500,
        ),
      );
    }
  }
  ResultFuture<Shoes> getCurrentShoes()async{
    try{
      final userData = await firestore.collection("users").doc(auth.currentUser!.uid).get();
      final userTemp = userData.data()!;
      final user = userModel.User.fromJson(userTemp);
      final shoesData = await firestore.collection("shoes").doc(user.currentShoes).get();
      final currentShoe = Shoes.fromJson(shoesData.data()!);
      return Right(currentShoe);
    }
    catch(e){
        return Left(
        ServerFailure(
          message: e.toString(),
          statusCode: 500,
        ),
      );
    }
  }
}