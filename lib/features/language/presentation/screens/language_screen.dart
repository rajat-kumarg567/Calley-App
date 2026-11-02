import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../controllers/language_controller.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key, this.fromSettings = false});

  final bool fromSettings;

  @override
  Widget build(BuildContext context) {
    final c = context.watch<LanguageController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Text('Choose Your Language',
                  style: AppTextStyles.inter(20, weight: FontWeight.w600)),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.border),
                ),
                clipBehavior: Clip.antiAlias,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  itemCount: c.languages.length,
                  itemBuilder: (_, i) {
                    final lang = c.languages[i];
                    return InkWell(
                      onTap: () => c.select(i),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(44, 10, 36, 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(lang.name,
                                      style: AppTextStyles.inter(15, weight: FontWeight.w500)),
                                  const SizedBox(height: 2),
                                  Text(lang.greeting,
                                      style: AppTextStyles.inter(14,
                                          color: const Color(0xFF374151))),
                                ],
                              ),
                            ),
                            _RadioDot(selected: i == c.selectedIndex),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: AppButton(
                label: 'Select',
                onPressed: () {
                  if (fromSettings) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.selected});
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: selected ? 2 : 1.3),
      ),
      child: selected
          ? Container(
        width: 11,
        height: 11,
        decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
      )
          : null,
    );
  }
}
