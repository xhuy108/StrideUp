import 'package:flutter/material.dart';
import 'package:stride_up/config/themes/app_palette.dart';

void showLoadingIndicator(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppPalette.primary,
        ),
      );
    },
  );
}
