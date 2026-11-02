import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/ui_helpers.dart';
import '../../../../shared/widgets/navy_header_card.dart';
import '../../../../shared/widgets/start_calling_bar.dart';
import '../../../../shared/widgets/user_banner.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../widgets/video_thumbnail.dart';

class GettingStartedScreen extends StatelessWidget {
  const GettingStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthController>().user;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          child: Column(
            children: [
              UserBanner(details: [
                Text('Hello ${user.name}',
                    style: AppTextStyles.inter(13, color: Colors.white)),
                const SizedBox(height: 2),
                Text(user.subscription,
                    style: AppTextStyles.inter(20,
                        weight: FontWeight.w700, color: Colors.white)),
              ]),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: NavyHeaderCard(
                    header: Text(
                      'If you are here for the first time then ensure that you have '
                          'uploaded the list to call from calley Web Panel hosted on '
                          '${AppConstants.webPanelUrl}',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.inter(14, color: Colors.white, height: 1.4),
                    ),
                    child: VideoThumbnail(
                      onTap: () => showAppSnack(context, 'Play video'), // TODO
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const StartCallingBar(showWhatsApp: true),
            ],
          ),
        ),
      ),
    );
  }
}
