import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/ui_helpers.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/auth_footer_text.dart';
import '../../../../shared/widgets/auth_scaffold.dart';
import '../../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<AuthController>();
    final ok = await auth.login(_email.text.trim(), _password.text);
    if (!mounted) return;
    if (ok) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.main, (_) => false);
    } else {
      showAppSnack(context, auth.error ?? 'Login failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<AuthController>().isLoading;
    return AuthScaffold(
      buttonLabel: 'Sign In',
      isLoading: loading,
      onPressed: _submit,
      footer: AuthFooterText(
        prefix: "Don't have an account?",
        actionLabel: 'Sign Up',
        onAction: () => Navigator.pushReplacementNamed(context, AppRoutes.register),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Welcome', style: AppTextStyles.heading),
            const SizedBox(height: 4),
            Text('Please sign-in to continue', style: AppTextStyles.subtitle),
            const SizedBox(height: 28),
            AppTextField(
              hint: 'Email address',
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              validator: Validators.email,
              suffix:  Icon(Icons.mail_outline, size: 22, color: AppColors.icon),
            ),
            const SizedBox(height: 20),
            AppTextField(
              hint: 'Password',
              controller: _password,
              obscureText: true,
              validator: Validators.password,
              suffix:  Icon(Icons.lock_outline, size: 22, color: AppColors.icon),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => showAppSnack(context, 'Forgot password - coming soon'),
                child: Text('Forgot Password?', style: AppTextStyles.inter(14.5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
