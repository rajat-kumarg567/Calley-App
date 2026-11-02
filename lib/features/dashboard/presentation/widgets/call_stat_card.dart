import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';

class CallStatCard extends StatelessWidget {
  const CallStatCard({
    super.key,
    required this.label,
    required this.count,
    required this.barColor,
    required this.backgroundColor,
  });

  final String label;
  final int count;
  final Color barColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 8, 14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 42,
            decoration: BoxDecoration(
              color: barColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.inter(14, weight: FontWeight.w500)),
                const SizedBox(height: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(count.toString().padLeft(2, '0'),
                        style: AppTextStyles.inter(24, weight: FontWeight.w800)),
                    const SizedBox(width: 4),
                    Text('Calls', style: AppTextStyles.inter(12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
