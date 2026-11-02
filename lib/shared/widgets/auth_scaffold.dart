import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'app_button.dart';
import 'calley_logo.dart';



/// Shared layout for Login / Register / OTP:
/// logo on top, white rounded card, centered scrollable [body],
/// and a pinned footer text + primary button.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.body,
    required this.footer,
    required this.buttonLabel,
    required this.onPressed,
    this.isLoading = false,
    this.horizontalPadding = 44,
  });

  final Widget body;
  final Widget footer;
  final String buttonLabel;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 28),
              child: CalleyLogo(),
            ),
            Expanded(
              // Outer = 1px border colour, inner = white card (top corners only).
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(1, 1, 1, 0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(23)),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, c) => SingleChildScrollView(
                            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(minHeight: c.maxHeight),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  child: body,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            footer,
                            const SizedBox(height: 14),
                            AppButton(
                              label: buttonLabel,
                              onPressed: onPressed,
                              isLoading: isLoading,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
