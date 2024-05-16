import 'dart:async';
import 'dart:convert';

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
import 'package:stride_up/features/running/widgets/running_information_item.dart';
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
  bool isRunning =false;
  late int timeCount;
  Timer? timer;
  String distanceRunText = '0 M';
  String timeText = '0:0:0';
  int currentDistance = 0;
  LatLng? currentLocation;
  final service = FlutterBackgroundService();
  Map<PolylineId,Polyline> polylines = {};
  final polylineId = PolylineId('polyline');
  CameraPosition? currentLocationCamera;
  late Stream<RunningStatus> runningStatusController;
  late StreamSubscription<RunningStatus> runningStatusSubscription;
  @override
  void initState(){
    super.initState();
    initalizeRunningPage();
  }
  Future<void> initalizeRunningPage() async{
    preferences = await SharedPreferences.getInstance();
    timeCount = runningPosistion.currentTime;
    Position firstPosition = await Geolocator.getCurrentPosition();
    setState(() {
      currentLocation = LatLng(firstPosition.latitude, firstPosition.longitude);
      currentLocationCamera = CameraPosition(target: currentLocation!, zoom: 15);
      isRunning = preferences.getBool(PREF_RUNNING_STATUS) ?? false;
    });
    if(preferences.getBool(PREF_RUNNING_STATUS)??false)
    {
      await listenLocationRunning();
    }
    service.invoke(ServiceMethod.CHECK_LOCATION_SERVICE);
    runningStatusController = Singleton.runningStatusController.stream;
    runningStatusSubscription = runningStatusController.listen((event)async {
        if(event == RunningStatus.PAUSED)
        {
          setState(() {
            isRunning = false;
          });
          await stopListenLocationRunning();
        }
        else{
          setState(() {
            isRunning = true;
          });
          await listenLocationRunning();
        }
      });
    runningStatusSubscription.resume();
  }
  Future<void> listenLocationRunning()async{
          timer = Timer.periodic(const Duration(milliseconds: 400), (timer) async{
      await preferences.reload();
      if(!(preferences.getBool(PREF_RUNNING_STATUS) ?? false )){
        timer.cancel();
        setState(() {
          isRunning = false;
          timeText = convertTimeToString(0);
        });
        await generatePolylineFromPoints([]);
        return;
      }
      var latitude = preferences.getDouble(PREF_LATITUDE);
      var longitude = preferences.getDouble(PREF_LONGITUDE);
      var time=preferences.getInt(PREF_RUNNING_TIMER);
      setState(() {
        timeText = convertTimeToString(time ?? 0);
      });
      if(latitude!=null && longitude!=null)
      {
        if(currentLocation!.latitude!=latitude && currentLocation!.longitude!=longitude)
        {
            String? jsonString = preferences.getString(PREF_LOCATION_CHECK_POINT);
            List<LatLng> latLngList = [];
            List<dynamic> dynamicListFromSharedPreferences = jsonString != null ? jsonDecode(jsonString): [];
            latLngList = dynamicListFromSharedPreferences.map((dynamic item) {
              // Ở đây, bạn cần xác định cách chuyển đổi từ mỗi phần tử dynamic sang LatLng
              // Ví dụ: giả sử mỗi phần tử dynamic là một List có 2 phần tử là latitude và longitude
              double latitude = item[0];
              double longitude = item[1];
              return LatLng(latitude, longitude);
            }).toList();
          setState((){
            currentLocation = LatLng(latitude, longitude);
            currentDistance = preferences.getInt(PREF_RUNNING_DISTANCE) ?? 0;
            distanceRunText = convertRunningDistanceToString(currentDistance);
          });
          await generatePolylineFromPoints(latLngList);

        }
      }
      });

  }
  Future<void> stopListenLocationRunning()async{
    /* 
    Lưu data ở đây 
    */
    // Xoá data
    if(timer!=null)
    {
      timer!.cancel();
      timer = null;
    }
    setState(() {
      timeText = convertTimeToString(0);
      distanceRunText = convertRunningDistanceToString(0);
      currentDistance = 0;
    });
    await generatePolylineFromPoints(runningPosistion.polylineCurrent);
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
    Singleton.runningStatusController.sink.add(RunningStatus.RESUMED);
    service.invoke(ServiceMethod.START_LOCATION_SERVICE);
  }
  Future<void> stopRunning() async{
    Singleton.runningStatusController.sink.add(RunningStatus.PAUSED);
    service.invoke(ServiceMethod.STOP_LOCATION_SERVICE);
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
                onTap: ()async {
                  await preferences.reload();
                 if(isRunning)
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
