import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class RunningPosition {
  // Tạo một hàm tạo riêng tư
  static final _runningPosition = new RunningPosition._internal();
  factory RunningPosition(){
    return _runningPosition;
  }
  RunningPosition._internal();
  // Biến instance thay vì biến static
  List<LatLng> polylineCurrent = [];
  bool isStartRunning = false;
  Timer? runningTimer;
  int currentTime = 0;
  int distanceRun = 0;
  LatLng? currentPostion;
}
final runningPosistion  = RunningPosition();