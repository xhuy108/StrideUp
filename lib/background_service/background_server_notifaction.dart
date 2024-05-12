import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stride_up/background_service/background_location.dart';
import 'package:stride_up/background_service/background_pedestrian_status.dart';
import 'package:stride_up/background_service/background_step_count.dart';
import 'package:stride_up/background_service/constant_service.dart';
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async{

  SharedPreferences preferences = await SharedPreferences.getInstance();
  int steps = 0;
    if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  service.on(ServiceMethod.CHECK_LOCATION_SERVICE).listen((event)async {
    await checkLocationChanged();
  });
  service.on(ServiceMethod.START_LOCATION_SERVICE).listen((event) async{
    await startLocationService();
  });
  service.on(ServiceMethod.STOP_LOCATION_SERVICE).listen((event) async{
    await stopLocationService();
  });
  service.on(ServiceMethod.START_PEDESTRAIN_SERVICE).listen((event) {
     startPedestrainStatusService();
   });
  service.on(ServiceMethod.STOP_PEDESTRAIN_SERVICE).listen((event) async{
    await stopPedestrainStatusService();
  });
  service.on(ServiceMethod.START_STEP_COUNT_SERVICE).listen((event) async{ 
   await startStepCount();
   });
  service.on(ServiceMethod.STOP_STEP_COUNT_SERVICE).listen((event) async{ 
   await stopStepCount();
  });
  service.on(ServiceMethod.START_NOTIFICATION_SERVICE).listen((event) async{
      BuildContext context = event?['context'];
          FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      flutterLocalNotificationsPlugin.show(
          888,
          'ZRace',
          'ZRace is counting',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              ServiceMethod.NOTFICATION_RUNNING_ID,
              'ZRace is Counting',
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );
  });
  service.on(ServiceMethod.STOP_NOTIFICATION_SERVICE).listen((event) async {
    FlutterLocalNotificationsPlugin().cancel(888);
  });
  await startStepCount();
}

Future<void> initializeNotificationService() async {
  final service = FlutterBackgroundService();
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    ServiceMethod.NOTFICATION_RUNNING_ID, // id
    'ZRace is Counting', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.low, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,
      // auto start service
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: ServiceMethod.NOTFICATION_RUNNING_ID, // this must match with notification channel you created above.
      initialNotificationTitle: 'ZRace is Counting',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
    ),iosConfiguration: IosConfiguration());
    service.startService();
  }