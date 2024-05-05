import 'dart:async';

import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stride_up/utils/singleton.dart';
import 'package:stride_up/utils/pref_constant.dart';

Stream<PedestrianStatus>? _pedestrianStatusStream;
StreamSubscription<PedestrianStatus>? _streamStatusSubscription;
  void startPedestrainStatusService()  {
    _pedestrianStatusStream ??= Pedometer.pedestrianStatusStream;
    _streamStatusSubscription ??= _pedestrianStatusStream!.listen(onPedestrianStatusChanged);
    _streamStatusSubscription!.onError(onPedestrianStatusError);
    if(_streamStatusSubscription!.isPaused)
    {
      _streamStatusSubscription!.resume();
    }
    Singleton.instanceLogger.d("Pedestrian Start");
  }
  Future<void> stopPedestrainStatusService() async{
    _pedestrianStatusStream ??= Pedometer.pedestrianStatusStream;
    _streamStatusSubscription ??= _pedestrianStatusStream!.listen(onPedestrianStatusChanged);
    _streamStatusSubscription!.onError(onPedestrianStatusError);
    _streamStatusSubscription!.pause();
    Singleton.instanceLogger.d("Pedestrian Stop");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(PREF_STATUS_PEDOMETER);
  }

  void onPedestrianStatusChanged(PedestrianStatus event) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(PREF_STATUS_PEDOMETER, event.status);
  }
  void onPedestrianStatusError(error)async {
    Singleton.instanceLogger.e(error);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(PREF_STATUS_PEDOMETER);
    _streamStatusSubscription!.cancel();
  }