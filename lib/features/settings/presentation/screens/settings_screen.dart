import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/ui_helpers.dart';
import '../../../../shared/widgets/navy_header_card.dart';
import '../../../../shared/widgets/user_banner.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../widgets/calling_lists_sheet.dart';
import '../widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthController>().user;
    final info = AppTextStyles.inter(13, color: Colors.white70);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Setting', style: AppTextStyles.inter(18, weight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          children: [
            UserBanner(
              avatarSize: 56,
              details: [
                Text('Hello ${user.name}',
                    style: AppTextStyles.inter(18,
                        weight: FontWeight.w700, color: Colors.white)),
                const SizedBox(height: 4),
                Text(user.email, style: info),
                const SizedBox(height: 2),
                Text(user.phone, style: info),
                const SizedBox(height: 2),
                Text('Parent Account: ${user.parentAccount}', style: info),
                const SizedBox(height: 2),
                Text('Current Subscription: ${user.subscription}', style: info),
              ],
            ),
            const SizedBox(height: 20),
            NavyHeaderCard(
              title: 'PROFILE SETTINGS',
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SettingsTile(
                      icon: Icons.language,
                      label: 'App Language',
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.language, arguments: true),
                    ),
                    const SizedBox(height: 12),
                    SettingsTile(
                      icon: Icons.password,
                      label: 'Change Password',
                      onTap: () => showAppSnack(context, 'Change password - coming soon'),
                    ),
                    const SizedBox(height: 12),
                    SettingsTile(
                      icon: Icons.list_alt_outlined,
                      label: 'Calling Lists',
                      onTap: () => showCallingListsSheet(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

