import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/safe_asset_image.dart';


class VideoThumbnail extends StatelessWidget {
  const VideoThumbnail({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1.39,
        child: Stack(
          fit: StackFit.expand,
          children: [
            SafeAssetImage(
              path: AppAssets.videoThumbnail,
              fit: BoxFit.cover,
              fallback: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFFFFFFF), Color(0xFFD9ECEF)],
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '2 MINUTE\nCHALLENGE',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.inter(30,
                      weight: FontWeight.w800, color: const Color(0xFF1E3566)),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 56,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE53935),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.play_arrow, color: Colors.white, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
