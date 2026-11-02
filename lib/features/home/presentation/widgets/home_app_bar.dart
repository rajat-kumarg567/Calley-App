import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/ui_helpers.dart';

/// "☰ Title" on the left, support + notification icons on the right.
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, required this.title});
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      automaticallyImplyLeading: false,
      titleSpacing: 20,
      title: Row(
        children: [
          Builder(
            builder: (ctx) => GestureDetector(
              onTap: () => Scaffold.of(ctx).openDrawer(),
              child: const Icon(Icons.menu, size: 28, color: Colors.black),
            ),
          ),
          const SizedBox(width: 8),
          Text(title, style: AppTextStyles.inter(18, weight: FontWeight.w600)),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => showAppSnack(context, 'Support - coming soon'),
          icon:  Icon(Icons.headset_mic_outlined, color: AppColors.icon),
        ),
        IconButton(
          onPressed: () => showAppSnack(context, 'No new notifications'),
          icon:  Icon(Icons.notifications_none_outlined, color: AppColors.icon),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
