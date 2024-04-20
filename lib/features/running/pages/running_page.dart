import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:stride_up/core/constraints/map_style.dart';
import 'package:stride_up/features/running/widgets/running_information_item.dart';

class RunningPage extends StatefulWidget {
  const RunningPage({super.key});

  @override
  State<RunningPage> createState() => _RunningPageState();
}

class _RunningPageState extends State<RunningPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            style: mapStyle,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
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
                    '52,67 KM',
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
                onTap: () {
                  debugPrint('Run');
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
