import 'package:calley_app/shared/widgets/safe_asset_image.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';


class AppAvatar extends StatelessWidget {
  const AppAvatar({super.key, this.size = 54});
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SafeAssetImage(
        path: AppAssets.avatar,
        width: size,
        height: size,
        fit: BoxFit.cover,
        fallback: Container(
          width: size,
          height: size,
          color: const Color(0xFFE94E6B),
          child: Icon(Icons.person, color: Colors.white, size: size * 0.6),
        ),
      ),
    );
  }
}
