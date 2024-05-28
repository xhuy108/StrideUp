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
  LatLng? currentLocation;
  final service = FlutterBackgroundService();
  Map<PolylineId, Polyline> polylines = {};
  final polylineId = PolylineId('polyline');
  CameraPosition? currentLocationCamera;
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }
  Future<void> getCurrentLocation() async{
    Position position =  await Geolocator.getCurrentPosition();
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
      currentLocationCamera = CameraPosition(target: currentLocation!,zoom: 15);
    });
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
                              value: '00:00',
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
                          '0.0KM',
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
                      },
                      child: Container(
                        padding: EdgeInsets.all(20.r),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppPalette.primary,
                        ),
                        child: Text(
                           'RUN',
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
