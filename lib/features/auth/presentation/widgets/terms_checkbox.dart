import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class TermsCheckbox extends StatelessWidget {
  const TermsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.onTermsTap,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final VoidCallback? onTermsTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(
            value: value,
            onChanged: (v) => onChanged(v ?? false),
            activeColor: AppColors.primary,
            side: const BorderSide(color: Color(0xFF9CA3AF), width: 1.2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text('I agree to the ', style: AppTextStyles.inter(15, color: Colors.black87)),
              GestureDetector(
                onTap: onTermsTap,
                child: Text('Terms and Conditions',
                    style: AppTextStyles.inter(15, color: AppColors.primary)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
