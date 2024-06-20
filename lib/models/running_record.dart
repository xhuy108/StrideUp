import 'package:google_maps_flutter/google_maps_flutter.dart';

class RunningRecord {
  String? id;
  final String userId;
  final int distanceGo;
  final List<LatLng> locationGo;
  final int time;
  final DateTime timeCreate;
  static const String COLLECTION_NAME = "running_record";
   RunningRecord({
    this.id,
    required this.userId,
    required this.distanceGo,
    required this.locationGo,
    required this.time,
    required this.timeCreate,
  });

  factory RunningRecord.fromJson(Map<String, dynamic> json) {
    return RunningRecord(
      userId: json['userId'],
      distanceGo: json['distanceGo'],
      locationGo: (json['locationGo'] as List)
          .map((item) => LatLng(item['latitude'], item['longitude']))
          .toList(),
      time: json['time'],
      timeCreate: DateTime.parse(json['timeCreate']),
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'distanceGo': distanceGo,
        'locationGo': locationGo
            .map((latLng) => {
                  'latitude': latLng.latitude,
                  'longitude': latLng.longitude,
                })
            .toList(),
        'time': time,
        'timeCreate': timeCreate.toIso8601String(),
      };
}
