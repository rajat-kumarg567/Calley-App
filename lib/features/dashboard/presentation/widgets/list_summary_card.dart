import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ListSummaryCard extends StatelessWidget {
  const ListSummaryCard({
    super.key,
    required this.listName,
    required this.total,
    required this.initial,
  });

  final String listName;
  final int total;
  final String initial;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(listName, style: AppTextStyles.inter(15, weight: FontWeight.w500)),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text('$total',
                        style: AppTextStyles.inter(34,
                            weight: FontWeight.w800, color: AppColors.primary)),
                    const SizedBox(width: 6),
                    Text('CALLS', style: AppTextStyles.inter(14)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 70,
            height: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(initial,
                style: AppTextStyles.inter(32,
                    weight: FontWeight.w700, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
