import 'dart:async';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stride_up/background_service/background_location.dart';

class Singleton{
  static final Logger instanceLogger = Logger();
  static final Singleton _singleton = Singleton._internal();

  // Factory method để trả về thể hiện duy nhất
  factory Singleton() {
    return _singleton;
  }

  // Constructor nội bộ
  Singleton._internal();

  // StreamController
  static final StreamController<RunningStatus> runningStatusController = StreamController<RunningStatus>.broadcast();
}