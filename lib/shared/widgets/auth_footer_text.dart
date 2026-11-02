import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/theme/app_text_styles.dart';


/// "Already have an account? **Sign In**" style line.
class AuthFooterText extends StatelessWidget {
  const AuthFooterText({
    super.key,
    required this.prefix,
    required this.actionLabel,
    required this.onAction,
  });

  final String prefix;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      children: [
        Text(prefix, style: AppTextStyles.inter(14.5)),
        GestureDetector(
          onTap: onAction,
          behavior: HitTestBehavior.opaque,
          child: Text(actionLabel,
              style: AppTextStyles.inter(14.5,
                  weight: FontWeight.w700, color: AppColors.primary)),
        ),
      ],
    );
  }
}
