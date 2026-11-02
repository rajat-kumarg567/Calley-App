import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import 'safe_asset_image.dart';

class WhatsAppButton extends StatelessWidget {
  const WhatsAppButton({super.key, this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.whatsapp),
        ),
        child:  Center(
          child: SafeAssetImage(
            path: AppAssets.whatsapp,
            width: 30,
            height: 30,
            fallback: FaIcon(FontAwesomeIcons.whatsapp, color: AppColors.whatsapp, size: 30),
          ),
        ),
      ),
    );
  }
}