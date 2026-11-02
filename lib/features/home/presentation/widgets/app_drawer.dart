import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../../../auth/models/user_model.dart';
import 'drawer_tile.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _go(BuildContext context, String route) {
    final nav = Navigator.of(context);
    nav.pop();
    nav.pushNamed(route);
  }

  void _soon(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Coming soon')));
  }

  Future<void> _logout(BuildContext context) async {
    final nav = Navigator.of(context);
    final auth = context.read<AuthController>();
    nav.pop();
    await auth.logout();
    nav.pushNamedAndRemoveUntil(AppRoutes.login, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthController>().user;

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.725,
      backgroundColor: AppColors.surfaceTint,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          _DrawerHeader(user: user),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              children: [
                DrawerTile(
                  icon: Icons.rocket_launch_outlined,
                  label: 'Getting Started',
                  onTap: () => _go(context, AppRoutes.gettingStarted),
                ),
                DrawerTile(
                    icon: Icons.cloud_sync_outlined,
                    label: 'Sync Data',
                    onTap: () => _soon(context)),
                DrawerTile(
                    icon: Icons.widgets_outlined,
                    label: 'Gamification',
                    onTap: () => _soon(context)),
                DrawerTile(
                    icon: Icons.perm_phone_msg_outlined,
                    label: 'Send Logs',
                    onTap: () => _soon(context)),
                DrawerTile(
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  onTap: () => _go(context, AppRoutes.settings),
                ),
                DrawerTile(
                    icon: Icons.headset_mic_outlined,
                    label: 'Help?',
                    onTap: () => _soon(context)),
                DrawerTile(
                    icon: Icons.person_off_outlined,
                    label: 'Cancel Subscription',
                    onTap: () => _soon(context)),
                const Divider(height: 28, thickness: 1, color: AppColors.border),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 6),
                  child: Text('App Info',
                      style: AppTextStyles.inter(17,
                          weight: FontWeight.w700, color: AppColors.primary)),
                ),
                DrawerTile(
                    icon: Icons.badge_outlined,
                    label: 'About Us',
                    onTap: () => _soon(context)),
                DrawerTile(
                    icon: Icons.privacy_tip_outlined,
                    label: 'Privacy Policy',
                    onTap: () => _soon(context)),
                DrawerTile(
                    icon: Icons.verified_outlined,
                    label: 'Version ${AppConstants.appVersion}',
                    onTap: () => _soon(context)),
                DrawerTile(
                    icon: Icons.share_outlined,
                    label: 'Share App',
                    onTap: () => _soon(context)),
                DrawerTile(
                    icon: Icons.logout,
                    label: 'Logout',
                    onTap: () => _logout(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 14, 20, 16),
      child: Row(
        children: [
          const AppAvatar(size: 56),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: user.name,
                      style: AppTextStyles.inter(18,
                          weight: FontWeight.w600, color: Colors.white),
                    ),
                    TextSpan(
                      text: '  •  ${user.plan}',
                      style: AppTextStyles.inter(14,
                          weight: FontWeight.w600, color: AppColors.accentYellow),
                    ),
                  ]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(user.email,
                    style: AppTextStyles.inter(13, color: Colors.white70),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
