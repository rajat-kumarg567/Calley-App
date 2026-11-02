import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'app_avatar.dart';



/// Blue rounded banner with the user avatar and any [details] widgets.
class UserBanner extends StatelessWidget {
  const UserBanner({super.key, required this.details, this.avatarSize = 54});

  final List<Widget> details;
  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          AppAvatar(size: avatarSize),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: details,
            ),
          ),
        ],
      ),
    );
  }
}
