import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/app_drawer.dart';
import '../widgets/home_app_bar.dart';


class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
      appBar: HomeAppBar(title: title),
      body: Center(
        child: Text('$title - coming soon',
            style: AppTextStyles.inter(16, color: AppColors.subtitle)),
      ),
    );
  }
}
