import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/arrow_box_icon.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({super.key, required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceTint,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Icon(icon, size: 22, color: AppColors.icon),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(label, style: AppTextStyles.inter(15, weight: FontWeight.w600)),
              ),
              const ArrowBoxIcon(),
            ],
          ),
        ),
      ),
    );
  }
}
