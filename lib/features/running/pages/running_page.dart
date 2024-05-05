import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stride_up/background_service/background_location.dart';
import 'package:stride_up/background_service/constant_service.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:stride_up/core/constraints/map_style.dart';
import 'package:stride_up/features/running/widgets/running_information_item.dart';
import 'package:stride_up/utils/pref_constant.dart';
import 'package:stride_up/utils/singleton.dart';

class RunningPage extends StatefulWidget {
  const RunningPage({super.key});
  
  @override
  State<RunningPage> createState() => _RunningPageState();
}

class _RunningPageState extends State<RunningPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late SharedPreferences preferences;
  late bool isRunning;
  late int timeCount;
  late Timer timer;
  String distanceRunText = '0 M';
  String timeText = '0:0:0';
  int currentDistance = 0;
  LatLng? currentLocation;
  final service = FlutterBackgroundService();
  Map<PolylineId,Polyline> polylines = {};
  final polylineId = PolylineId('running_person_polyline');

  CameraPosition? currentLocationCamera;
  @override
  void initState(){
    super.initState();
    initalizeRunningPage();
  }
  Future<void> initalizeRunningPage() async{
    preferences = await SharedPreferences.getInstance();
    timeCount = RunningPosition.currentTime;
    Position firstPosition = await Geolocator.getCurrentPosition();
    setState(() {
      currentLocation = LatLng(firstPosition.latitude, firstPosition.longitude);
      currentLocationCamera = CameraPosition(target: currentLocation!, zoom: 15);
    });
    if(RunningPosition.isStartRunning)
    {
      await listenLocationRunning();
    }
  }
  Future<void> listenLocationRunning()async{
          timer = Timer.periodic(Duration(seconds: 1), (timer) async{ 
      await preferences.reload();
      var latitude = preferences.getDouble(PREF_LATITUDE);
      var longitude = preferences.getDouble(PREF_LONGITUDE);
      setState(() {
        timeText = convertTimeToString(RunningPosition.currentTime);
      });
      if(latitude!=null && longitude!=null)
      {
        if(currentLocation!.latitude!=latitude && currentLocation!.longitude!=longitude)
        {
          setState(() {
            currentLocation = LatLng(latitude, longitude);
            currentDistance = preferences.getInt(PREF_RUNNING_DISTANCE) ?? 0;
            distanceRunText = convertRunningDistanceToString(currentDistance);
          });
          await generatePolylineFromPoints(RunningPosition.polylineCurrent);
        }
      }
      });
  }
  Future<void> stopListenLocationRunning()async{
    /* 
    Lưu data ở đây 
    */
    // Xoá data
    timer.cancel();
    await generatePolylineFromPoints(RunningPosition.polylineCurrent);
  }
  String convertTimeToString(int time){
    int hour = (time/3600).floor();
    int min = ((time - hour*3600 ) /60).floor();
    int seconds = time - hour*3600 - min*60 ;
    return '$hour:$min:$seconds';
  }
  String convertRunningDistanceToString(int distance){
    if(distance<1000)
    {
      return '$distance M';
    }
    return '${(distance/1000).toDouble()} KM';
  }
  Future<void> startRunning() async{
    service.invoke(ServiceMethod.START_LOCATION_SERVICE);
    await listenLocationRunning();
  }
  Future<void> stopRunning() async{
    service.invoke(ServiceMethod.STOP_LOCATION_SERVICE);
    await stopListenLocationRunning();
  }
  Future<void> generatePolylineFromPoints(List<LatLng> polylineCoordinates) async{

    final polyline = Polyline(polylineId: polylineId,
    color: const Color.fromARGB(255, 247, 90, 40),
    points: polylineCoordinates,
    width: 5);
    setState(() {
      polylines[polylineId] = polyline;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  currentLocation == null ?const Center(child: CircularProgressIndicator(),): Stack(
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
                markerId: MarkerId("currentLocation"), // Đảm bảo markerId là duy nhất
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RunningInformationItem(
                        value: '6’38’’',
                        title: 'Time',
                      ),
                      RunningInformationItem(
                        value: '0:52',
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
                    currentLocation!.latitude.toString(),
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
                onTap: ()async {
                 if( RunningPosition.isStartRunning)
                 {
                  await stopRunning();
                 }
                 else{
                  await startRunning();
                 }
                },
                child: Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppPalette.primary,
                  ),
                  child: Text(
                    RunningPosition.isStartRunning ? 'STOP' : 'RUN',
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
