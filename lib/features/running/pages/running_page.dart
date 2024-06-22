import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stride_up/background_service/constant_service.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:stride_up/core/constraints/map_style.dart';
import 'package:stride_up/core/utils/typedefs.dart';
import 'package:stride_up/features/running/repositories/running_repository.dart';
import 'package:stride_up/features/running/utils/show_running_result.dart';
import 'package:stride_up/features/running/widgets/running_information_item.dart';
import 'package:stride_up/models/running_record.dart';
import 'package:stride_up/models/shoes.dart';
import 'package:stride_up/utils/pref_constant.dart';
import '../../../background_service/background_location.dart';
import '../../../utils/running_position.dart';
import '../../../utils/singleton.dart';

class RunningPage extends StatefulWidget {
  const RunningPage({super.key});

  @override
  State<RunningPage> createState() => _RunningPageState();
}

class _RunningPageState extends State<RunningPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late SharedPreferences preferences;
  bool isRunning = false;
  int timeCount = 0;
  Timer? timer;
  String distanceRunText = '0 M';
  String timeText = '0:0:0';
  late RunningReporsitory runningReporsitory;
  int currentDistance = 0;
  LatLng? currentLocation;  
  List<LatLng> _route = [];
  Map<PolylineId, Polyline> polylines = {};
  final polylineId = PolylineId('polyline');
  CameraPosition? currentLocationCamera;
  late Shoes currentShoes;
  StreamSubscription<Position>? _positionStreamSubscription;
  @override
  void initState() {
    super.initState();
    runningReporsitory = const RunningReporsitory();
    _listenLocationChange();
    getCurrentShoes();
  }
  void initTimer(){
    timer = Timer.periodic(const Duration(seconds: 1), (timer) { 
      setState(() {
        timeCount+=1;
        timeText = convertTimeToString(timeCount);
      });
    });
    
  }
  Future<void> getCurrentShoes()async{
    final result = await runningReporsitory.getCurrentShoes();
    result.fold((e) {Singleton.instanceLogger.e("shoesError $e");}, (r) {
      currentShoes = r;
      print("currentShoes $currentShoes");
    });
  }
void _listenLocationChange() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10
    );

    _positionStreamSubscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position position) {
        setState(() {
          if(!isRunning)
          {
            if(currentLocation==null){
              currentLocationCamera = CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 15);
              _route.add(LatLng(position.latitude, position.longitude));
            }
            currentLocation = LatLng(position.latitude, position.longitude);

          }
          else{
            setState(() {
              currentDistance+= Geolocator.distanceBetween(currentLocation!.latitude, currentLocation!.longitude, position.latitude, position.longitude).toInt();
              distanceRunText = convertRunningDistanceToString(currentDistance);
            });
            currentLocation = LatLng(position.latitude, position.longitude);
            _route.add(currentLocation!);

            generatePolylineFromPoints(_route);
          }
        });
      },
      onError: (error) {
        print('Error: $error');
      },
    );
    _positionStreamSubscription!.resume();
  }
  String convertTimeToString(int time) {
    int hour = (time / 3600).floor();
    int min = ((time - hour * 3600) / 60).floor();
    int seconds = time - hour * 3600 - min * 60;
    return '$hour:$min:$seconds';
  }
  int caculateMoney(int luck, int energy, double time, double distance){
    double totalKilometers = (energy-5)*2+ 8;
    double kilometerDistance = (distance/1000);
    int distanceGo = kilometerDistance>totalKilometers ? totalKilometers.toInt() : kilometerDistance.floor();
    int initialCoin = distanceGo;
    int totalCoin = initialCoin;
    for(int i =0;i<initialCoin;i++){
      if(random((luck-5)*10)) {
        totalCoin+=1;
      }
    }
    return totalCoin;
  }
  bool random(int percentage) {
  if (percentage < 0 || percentage > 100) {
    throw ArgumentError('Percentage must be between 0 and 100');
  }
  Random rand = Random();
  int randomValue = rand.nextInt(100); // Generates a random integer from 0 to 99
  
  return randomValue < percentage;
  }
  String convertRunningDistanceToString(int distance) {
    if (distance < 1000) {
      return '$distance M';
    }
    return '${(distance / 1000).toDouble()} KM';
  }

  Future<void> generatePolylineFromPoints(
      List<LatLng> polylineCoordinates) async {
    final polyline = Polyline(
        polylineId: polylineId,
        color: const Color.fromARGB(255, 247, 90, 40),
        points: polylineCoordinates,
        width: 5);
    setState(() {
      polylines[polylineId] = polyline;
    });
  }
  void startRunning(){
    setState(() {
      isRunning = true;
    });
    initTimer();
  }
  void stopRunning()async {
    RunningRecord runningRecord = RunningRecord(userId: FirebaseAuth.instance.currentUser!.uid, distanceGo: currentDistance,
       locationGo: _route, time: timeCount, timeCreate: DateTime.now(),coin: caculateMoney(currentShoes.luck, currentShoes.energy,timeCount.toDouble(), currentDistance.toDouble()));
    setState(() {
      isRunning = false;
      timer!.cancel();
      timer = null;
      timeCount = 0;
      timeText = convertTimeToString(timeCount);
      currentDistance = 0;
      distanceRunText = convertRunningDistanceToString(currentDistance);
      _route.clear();
      polylines[polylineId] =  Polyline(
        polylineId: polylineId,
        color: const Color.fromARGB(255, 247, 90, 40),
        points: _route,
        width: 5);

    });
      final response = await runningReporsitory.upRunningStatus(runningRecord);
      showRunningResultDialog(context,runningRecord);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: currentLocationCamera!,
                  style: mapStyle,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: {
                    Marker(
                      markerId: MarkerId(
                          "currentLocation"), // Đảm bảo markerId là duy nhất
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueOrange),
                      position: currentLocation!,
                    )
                  },
                  polylines: Set<Polyline>.of(polylines.values),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.w,
                      vertical: 32.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppPalette.background.withOpacity(0.9),
                          AppPalette.background.withOpacity(0.1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RunningInformationItem(
                              value: '6’38’’',
                              title: 'Time',
                            ),
                            RunningInformationItem(
                              value: timeText,
                              title: 'Time',
                            ),
                            RunningInformationItem(
                              value: '410kcal',
                              title: 'Calories',
                            ),
                          ],
                        ),
                        Gap(60.h),
                        Text(
                          distanceRunText,
                          style: TextStyle(
                            fontSize: 38.sp,
                            fontWeight: FontWeight.w700,
                            color: AppPalette.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 50.h,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () async {
                        if (isRunning) {
                          stopRunning();
                        } else {
                          startRunning();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(20.r),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppPalette.primary,
                        ),
                        child: Text(
                          isRunning ? 'STOP' : 'RUN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
