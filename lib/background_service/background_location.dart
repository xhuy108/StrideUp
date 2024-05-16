

import 'dart:async';
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/pref_constant.dart';
import '../utils/running_position.dart';
import '../utils/singleton.dart' ;
import 'dart:convert';
Stream<RunningStatus>? running_status_stream;
StreamSubscription<Position>? _positionStreamSubscription;
final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

Future<void> startLocationService() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    if (!runningPosistion.isStartRunning) {
    var currentPoint = await Geolocator.getCurrentPosition();
    runningPosistion.currentPostion = LatLng(currentPoint.latitude, currentPoint.longitude);
    runningPosistion.polylineCurrent.add(runningPosistion.currentPostion!);
    preferences.setBool(PREF_RUNNING_STATUS, true);
    runningPosistion.runningTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      preferences.setInt(PREF_RUNNING_TIMER, ++runningPosistion.currentTime);
    });
    if (_positionStreamSubscription == null) {
      final positionStream = _geolocatorPlatform.getPositionStream();
      _positionStreamSubscription = positionStream.handleError(errorLocationChange)
      .listen((position) {
        preferences.setDouble(PREF_LATITUDE, position.latitude);
        preferences.setDouble(PREF_LONGITUDE, position.longitude);
        double distanceCheck = FlutterMapMath().distanceBetween(position.latitude, position.longitude, runningPosistion.polylineCurrent.last.latitude, runningPosistion.polylineCurrent.last.longitude,"meters");
          if(distanceCheck>3)
          {
              runningPosistion.currentPostion = LatLng(position.latitude, position.longitude);
              runningPosistion.polylineCurrent.add(LatLng(position.latitude, position.longitude));
              preferences.setString(PREF_LOCATION_CHECK_POINT, jsonEncode(runningPosistion.polylineCurrent));
              runningPosistion.distanceRun += distanceCheck.toInt();
              preferences.setInt(PREF_RUNNING_DISTANCE,runningPosistion.distanceRun);
          }
      });
      _positionStreamSubscription!.pause();
    }
    if (_positionStreamSubscription == null) {
        return;
    }
      _positionStreamSubscription!.resume();
      Singleton.instanceLogger.d('location state: ${RunningStatus.RESUMED}');
      runningPosistion.isStartRunning = true;
      }

 }
 Future<void> stopLocationService() async{
  if(runningPosistion.isStartRunning && _positionStreamSubscription!=null){
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    if (runningPosistion.runningTimer != null) {
      runningPosistion.runningTimer!.cancel();
      runningPosistion.runningTimer = null;
      runningPosistion.currentTime = 0;
      preferences.setInt(PREF_RUNNING_TIMER, 0);
      preferences.setBool(PREF_RUNNING_STATUS, false);
      preferences.remove(PREF_RUNNING_TIMER);
      preferences.remove(PREF_LOCATION_CHECK_POINT);
      preferences.remove(PREF_RUNNING_DISTANCE);
      preferences.remove(PREF_RACING_STATUS);
    }
    Singleton.instanceLogger.d('location state: ${RunningStatus.PAUSED}');
    _positionStreamSubscription!.pause();
    Singleton.runningStatusController.sink.add(RunningStatus.PAUSED);
    runningPosistion.isStartRunning = false;
    runningPosistion.polylineCurrent.clear();
    runningPosistion.distanceRun = 0;

    preferences.remove(PREF_RUNNING_DISTANCE);
  }
}
 void errorLocationChange(error)async {
    var sharedPreferences = await SharedPreferences.getInstance();
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
    sharedPreferences.remove(PREF_LATITUDE);
    sharedPreferences.remove(PREF_LONGITUDE);
    sharedPreferences.remove(PREF_RUNNING_TIMER);
    sharedPreferences.remove(PREF_LOCATION_CHECK_POINT);
    sharedPreferences.remove(PREF_RUNNING_DISTANCE);
    sharedPreferences.remove(PREF_RACING_STATUS);
    runningPosistion.isStartRunning = false;
    runningPosistion.distanceRun = 0;
    runningPosistion.polylineCurrent.clear();
    Singleton.instanceLogger.e('LocationError: $error');
 }
 Future<void> checkLocationChanged()async {
    if(!runningPosistion.isStartRunning) {
      SharedPreferences  sharedPreferences =  await SharedPreferences.getInstance(); 
      sharedPreferences.remove(PREF_RUNNING_TIMER);
      sharedPreferences.remove(PREF_LOCATION_CHECK_POINT);
      sharedPreferences.setBool(PREF_RUNNING_STATUS, false);
      sharedPreferences.remove(PREF_RACING_STATUS);
    }

 }
 enum RunningStatus{
  // ignore: constant_identifier_names
  RESUMED ,
  PAUSED 

 }