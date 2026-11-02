import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import 'safe_asset_image.dart';

class CalleyLogo extends StatelessWidget {
  const CalleyLogo({super.key, this.height = 64});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SafeAssetImage(
      path: AppAssets.logo,
      height: height,
      fit: BoxFit.contain,
      fallback: Icon(Icons.phone_in_talk, size: height, color: AppColors.calleyBlue),
    );
  }
}