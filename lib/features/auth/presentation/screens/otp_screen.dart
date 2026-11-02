import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/ui_helpers.dart';
import '../../../../shared/widgets/auth_footer_text.dart';
import '../../../../shared/widgets/auth_scaffold.dart';
import '../../controllers/auth_controller.dart';
import '../widgets/otp_input.dart';
import '../../../../core/routes/app_routes.dart';


class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.phone});
  final String phone;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _otp = '';

  Future<void> _verify() async {
    if (_otp.length < 6) {
      showAppSnack(context, 'Please enter the 6 digit OTP');
      return;
    }
    final auth = context.read<AuthController>();
    // final ok = await auth.verifyOtp(widget.phone, _otp);
    final ok = await auth.verifyOtp(_otp);
    if (!mounted) return;
    if (ok) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.main , (_) => false);
    } else {
      showAppSnack(context, auth.error ?? 'Verification failed');
    }
  }

  Future<void> _resend() async {
    final ok = await context.read<AuthController>().resendOtp(widget.phone);
    if (!mounted) return;
    showAppSnack(context, ok ? 'OTP sent again' : 'Could not resend OTP');
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<AuthController>().isLoading;
    return AuthScaffold(
      horizontalPadding: 30,
      buttonLabel: 'Verify',
      isLoading: loading,
      onPressed: _verify,
      footer: AuthFooterText(
        prefix: "Didn't receive OTP code?",
        actionLabel: 'Resend OTP',
        onAction: _resend,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Whatsapp OTP Verification',
              textAlign: TextAlign.center, style: AppTextStyles.heading),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
                'Please ensure that the mobile number mentioned is valid as we have sent an OTP to your WhatsApp.',
              textAlign: TextAlign.center,
              style: AppTextStyles.inter(14, color: AppColors.subtitle, height: 1.4),
            ),
          ),
          const SizedBox(height: 28),
          OtpInput(onChanged: (v) => _otp = v),
          const SizedBox(height: 22),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.phone, style: AppTextStyles.inter(15)),
                const SizedBox(width: 6),
                 Icon(Icons.edit_outlined, size: 16, color: AppColors.icon),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
