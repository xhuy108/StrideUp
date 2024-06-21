import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stride_up/core/errors/failures.dart';
import 'package:stride_up/core/utils/typedefs.dart';
import 'package:stride_up/models/wallet.dart';
import "package:stride_up/models/user.dart" as userModel;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
class WalletRepository{
  const WalletRepository();
  ResultFuture<void> createNewWallet(String publicAddress, String privateAddress, String code) async {
    try{
      String userId = auth.currentUser!.uid;
      HashMap<String, dynamic> data = HashMap();
      data["publicAddress"] = publicAddress;
      data["code"] = code;
      data["privateAddress"] = privateAddress;
      data["zCoin"] = 0;
      data["bnbCoin"] = 0;
      final respone = await firebaseFirestore.collection(Wallet.COLLECTION_NAME).doc(userId).set(data);
      return const Right(null);
    }catch(e){
      return Left(
        ServerFailure(
          message: e.toString(),
          statusCode: 500,
        ),
      );
    }
  }
    Stream<DocumentSnapshot<Map<String, dynamic>>> getWalletSnapshot(){
    return firebaseFirestore.collection(Wallet.COLLECTION_NAME).doc(auth.currentUser!.uid).snapshots();
  }
  ResultFuture<void> createWalletCode(String code) async{
    try{
      String userId = auth.currentUser!.uid;
      HashMap<String, dynamic> data = HashMap();
      data["code"] = code;
      final respone = await firebaseFirestore.collection(Wallet.COLLECTION_NAME).doc(userId).set(data);
      return const Right(null);
    }catch(e){
        return Left(
        ServerFailure(
          message: e.toString(),
          statusCode: 500,
        ),
      );
    }
  }
  ResultFuture<bool> checkWallet()async{
    try{
        String userId = auth.currentUser!.uid;
        final respone = await firebaseFirestore.collection(Wallet.COLLECTION_NAME).doc(userId).get();
        if(respone.exists) {
          return const Right(true);
        } else {
          return const Right(false);
        }

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
    ResultFuture<bool> checkWalletPasscode(String code)async{
    try{
        String userId = auth.currentUser!.uid;
        final respone = await firebaseFirestore.collection(Wallet.COLLECTION_NAME).doc(userId).get();
        Wallet wallet = Wallet.fromJson(respone.data()!);
        if(wallet.code == code)
          return const Right(true);
        else{
          return const Right(false);
        }
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
  ResultFuture<Wallet> getWallet()async{
    try{
        String userId = auth.currentUser!.uid;
        final respone = await firebaseFirestore.collection(Wallet.COLLECTION_NAME).doc(userId).get();
        if(respone.exists)
        {
          Wallet wallet = Wallet.fromJson(respone.data()!);
          return Right(wallet);
        }

        return const Left(
          ServerFailure(
          message: "wallet is not existed",
          statusCode: 500,
          ));

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
  ResultFuture<bool> checkCoin(int coin) async{
    try{
      final user =await firebaseFirestore.collection("user").doc(auth.currentUser!.uid).get();
      final UserData = userModel.User.fromJson(user.data()!);
      if(UserData.coin>coin) {
        return const Right(true);
      }
      return const Right(false);
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
    ResultFuture<bool> checkzCoin(int zCoin) async{
    try{
      final wallet =await firebaseFirestore.collection("wallet").doc(auth.currentUser!.uid).get();
      final walletData = Wallet.fromJson(wallet.data()!);
      if(walletData.zCoin>zCoin) {
        return const Right(true);
      }
      return const Right(false);
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