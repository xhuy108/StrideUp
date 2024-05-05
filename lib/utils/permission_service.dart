
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<void> requestNotificationPermission() async
  {
    await Permission.notification.isDenied.then((value) {
        if (value) {
          Permission.notification.request();
        }
      });
  }
  static Future<void> requestLocationPermission() async
  {
    await Permission.location.isDenied.then((value) {
        if (value) {
          Permission.location.request();
        }
      });
  }
  static Future<void> requestPedometerPermission() async
  {
    await Permission.activityRecognition.isDenied.then((value) {
        if (value) {
          Permission.activityRecognition.request();
        }
      });
  }

}
