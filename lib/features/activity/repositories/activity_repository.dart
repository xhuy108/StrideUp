import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stride_up/core/errors/failures.dart';
import 'package:stride_up/core/utils/typedefs.dart';
import 'package:stride_up/models/activity.dart';
import 'package:stride_up/models/running_record.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
class ActivityRepository{
  const ActivityRepository();
  ResultFuture<Activity> getRecordByDate(DateTime date) async{
    try{
      final startOfDay = Timestamp.fromDate(getStartOfWeek(date));
      final endOfDay = Timestamp.fromDate(getEndOfWeek(date));
      final response = await firestore.collection(RunningRecord.COLLECTION_NAME)
      .where("timeCreate",isGreaterThanOrEqualTo: startOfDay).where("timeCreate", isLessThanOrEqualTo: endOfDay)
      .where("userId",isEqualTo: auth.currentUser!.uid).get();
      final records = response.docs.map((doc) => RunningRecord.fromJson(doc.data())).toList();
      double totalDistance = 0;
      double totalTime = 0;
      HashMap<DateTime,bool> checkDate = HashMap();
      for(var record in records){
        if(record.timeCreate.day == date.day && record.timeCreate.month == date.month)
        {
          totalTime+= record.time;
          totalDistance += record.distanceGo;
        }
        checkDate[record.timeCreate] = true;
      }
      double avgSpeed = calculateMinutesPerKilometer(totalTime,totalDistance);
      Activity activity = Activity(activeDateOfWeek: checkDate.length, userId: auth.currentUser!.uid, totalDistance: totalDistance, avgSpeed: avgSpeed, activeTime: totalTime);
      return Right(activity);
    }
    catch(e){
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }
}
DateTime getStartOfWeek(DateTime date) {
  // Lấy ngày trong tuần của ngày cụ thể
  int dayOfWeek = date.weekday; // 1 = Monday, ..., 7 = Sunday

  // Tính toán ngày bắt đầu tuần (thường là thứ Hai)
  DateTime startOfWeek = date.subtract(Duration(days: dayOfWeek - 1));
  
  return startOfWeek;
}
DateTime getEndOfWeek(DateTime date) {
  // Lấy ngày đầu tuần
  DateTime startOfWeek = getStartOfWeek(date);

  // Tính toán ngày cuối tuần (thường là Chủ Nhật)
  DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
  endOfWeek = DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59);
  return endOfWeek;
}

double calculateMinutesPerKilometer(double totalSeconds, double totalMeters) {
  if (totalMeters == 0) {
    return 0;
  }
  
  // Chuyển đổi tổng số giây thành phút
  double totalMinutes = totalSeconds;
  
  // Chuyển đổi tổng số mét thành kilômét
  double totalKilometers = totalMeters / 1000.0;

  return totalMinutes / totalKilometers;
}
