import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/navy_header_card.dart';
import '../../../../shared/widgets/safe_asset_image.dart';
import '../../../../shared/widgets/start_calling_bar.dart';
import '../../../../shared/widgets/user_banner.dart';

class DashboardEmptyView extends StatelessWidget {
  const DashboardEmptyView({super.key, required this.userName});
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        children: [
          UserBanner(details: [
            Text('Hello $userName',
                style: AppTextStyles.inter(13, color: Colors.white)),
            const SizedBox(height: 2),
            Text('Welcome to Calley!',
                style: AppTextStyles.inter(20,
                    weight: FontWeight.w700, color: Colors.white)),
          ]),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: NavyHeaderCard(
                title: 'LOAD NUMBER TO CALL',
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(28, 28, 28, 12),
                      child: Text.rich(
                        TextSpan(
                          style: AppTextStyles.inter(15, height: 1.5),
                          children: [
                            const TextSpan(text: 'Visit '),
                            TextSpan(
                              text: AppConstants.webPanelUrl,
                              style: const TextStyle(color: AppColors.primary),
                            ),
                            const TextSpan(
                              text:
                              ' to upload numbers that you wish to call using Calley Mobile App.',
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: const SafeAssetImage(
                        path: AppAssets.loadNumbers,
                       // width: double.infinity,
                        height: 240,
                        fit: BoxFit.contain,
                        fallback: SizedBox(
                          height: 240,
                          child: Center(
                            child: Icon(Icons.cloud_upload_outlined,
                                size: 96, color: AppColors.primary),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const StartCallingBar(showWhatsApp: true),
        ],
      ),
    );
  }
}
