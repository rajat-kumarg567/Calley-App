import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// 5-item bottom bar; the middle item is the highlighted blue "play" pill.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _icons = <IconData>[
    Icons.home_outlined,
    Icons.contact_page_outlined,
    Icons.play_arrow_outlined,
    Icons.phone_callback_outlined,
    Icons.pending_actions_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(1, 1, 1, 0),
        padding: EdgeInsets.only(
          top: 12,
          bottom: 12 + MediaQuery.of(context).padding.bottom,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFFF0F5FF),
          borderRadius: BorderRadius.vertical(top: Radius.circular(23)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(_icons.length, (i) {
            final isCenter = i == 2;
            final selected = i == currentIndex;
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTap(i),
              child: isCenter
                  ? Container(
                width: 70,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Icon(_icons[i], color: Colors.white, size: 30),
              )
                  : Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  _icons[i],
                  size: 26,
                  color: selected ? AppColors.primary : AppColors.icon,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
