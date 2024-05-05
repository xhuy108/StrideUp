import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stride_up/utils/singleton.dart';
import 'package:stride_up/utils/pref_constant.dart';

Stream<StepCount>? _stepCountStream;
StreamSubscription<StepCount>? _stepSubscription;
Future<void> startStepCount() async{
  Singleton.instanceLogger.d('$PREF_STEPS_PEDOMETER resumes');
  _stepCountStream ??= Pedometer.stepCountStream;
  _stepSubscription = _stepCountStream!.listen(onStepCount);
  _stepSubscription!.onError(onStepError);
  if(_stepSubscription!.isPaused)
  {
    _stepSubscription!.resume();
  }
}
Future<void> stopStepCount() async{
  Singleton.instanceLogger.d('$PREF_STEPS_PEDOMETER stop');
  _stepSubscription!.pause();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.remove(PREF_STEPS_PEDOMETER);
}
void onStepCount(StepCount event) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(PREF_STEPS_PEDOMETER, event.steps);
  }

void onStepError(error) {
  Singleton.instanceLogger.e('onStepCountError: $error');
}
