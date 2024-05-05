

import 'dart:async';
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stride_up/utils/singleton.dart';
import 'package:stride_up/utils/pref_constant.dart';

StreamSubscription<Position>? _positionStreamSubscription;
final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

class RunningPosition{
  static List<LatLng> polylineCurrent = [];
  static bool isStartRunning = false;
  static Timer? runningTimer;
  static int currentTime = 0;
  static int distanceRun = 0;
  static LatLng? currentPostion;
}
Future<void> startLocationService() async {
    if (!RunningPosition.isStartRunning) {
    var currentPoint = await Geolocator.getCurrentPosition();
    RunningPosition.currentPostion = LatLng(currentPoint.latitude, currentPoint.longitude);
    RunningPosition.polylineCurrent.add(RunningPosition.currentPostion!);
    Singleton.instanceLogger.d('location state: ${RunningStatus.RESUMED}');
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(PREF_RUNNING_STATUS, true);
    RunningPosition.runningTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      preferences.setInt(PREF_RUNNING_TIMER, ++RunningPosition.currentTime);
    });
    if (_positionStreamSubscription == null) {
      final positionStream = _geolocatorPlatform.getPositionStream();
      _positionStreamSubscription = positionStream.handleError(errorLocationChange)
      .listen((position) {
        double distanceCheck = FlutterMapMath().distanceBetween(position.latitude, position.longitude, RunningPosition.polylineCurrent.last.latitude, RunningPosition.polylineCurrent.last.longitude,"meters");
          if(distanceCheck>5)
          {
              RunningPosition.currentPostion = LatLng(position.latitude, position.longitude);
              preferences.setDouble(PREF_LATITUDE, position.latitude);
              preferences.setDouble(PREF_LONGITUDE, position.longitude);
              RunningPosition.polylineCurrent.add(LatLng(position.latitude, position.longitude));
              RunningPosition.distanceRun += distanceCheck.toInt();
          }
      });
      _positionStreamSubscription!.pause();
    }
    if (_positionStreamSubscription == null) {
        return;
    }
      _positionStreamSubscription!.resume();
      RunningPosition.isStartRunning = true;
        preferences.setString(PREF_RACING_STATUS, RunningStatus.RESUMED);
      } 
 }
 Future<void> stopLocationService() async{
  if(RunningPosition.isStartRunning && _positionStreamSubscription!=null){
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    if (RunningPosition.runningTimer != null) {
      RunningPosition.runningTimer!.cancel();
      RunningPosition.runningTimer = null;
      RunningPosition.currentTime = 0;
      preferences.setInt(PREF_RUNNING_TIMER, 0);
      preferences.setBool(PREF_RUNNING_STATUS, false);
    }
    Singleton.instanceLogger.d('location state: ${RunningStatus.PAUSED}');
    _positionStreamSubscription!.pause();
    preferences.setString(PREF_RACING_STATUS, RunningStatus.PAUSED);
    RunningPosition.isStartRunning = !RunningPosition.isStartRunning;
    RunningPosition.polylineCurrent.clear();
    RunningPosition.distanceRun = 0;
    preferences.remove(PREF_LATITUDE);
    preferences.remove(PREF_LONGITUDE);
    preferences.remove(PREF_RUNNING_DISTANCE);
  }
}
 void errorLocationChange(error)async {
    var sharedPreferences = await SharedPreferences.getInstance();
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
    sharedPreferences.remove(PREF_LATITUDE);
    sharedPreferences.remove(PREF_LONGITUDE);
    RunningPosition.isStartRunning = false;
    RunningPosition.distanceRun = 0;
    RunningPosition.polylineCurrent.clear();
    Singleton.instanceLogger.e('LocationError: $error');
 }
 class RunningStatus{
  // ignore: constant_identifier_names
  static const String RESUMED = 'resumed';
  static const String PAUSED = 'paused';

 }