import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stride_up/core/errors/failures.dart';
import 'package:stride_up/core/utils/typedefs.dart';
import 'package:stride_up/models/running_record.dart';

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
}