import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/theme/app_text_styles.dart';



/// Dark navy card with a header ([title] or custom [header]) and a white body.
class NavyHeaderCard extends StatelessWidget {
  const NavyHeaderCard({super.key, this.title, this.header, required this.child})
      : assert(title != null || header != null);

  final String? title;
  final Widget? header;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            child: header ??
                Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.inter(15,
                      weight: FontWeight.w700, color: Colors.white),
                ),
          ),
          Container(
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
