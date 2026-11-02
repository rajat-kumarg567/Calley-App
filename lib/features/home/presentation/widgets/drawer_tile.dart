import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Drawer row: icon inside a white pill + label.
class DrawerTile extends StatelessWidget {
  const DrawerTile({super.key, required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(15),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Icon(icon, size: 22, color: AppColors.icon),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(label, style: AppTextStyles.inter(15, weight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }
}
