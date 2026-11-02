import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/ui_helpers.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/auth_footer_text.dart';
import '../../../../shared/widgets/auth_scaffold.dart';
import '../../../../shared/widgets/india_flag.dart';
import '../../controllers/auth_controller.dart';
import '../widgets/terms_checkbox.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const _countryCode = '+91';

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _mobile = TextEditingController();
  bool _agreed = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _mobile.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreed) {
      showAppSnack(context, 'Please accept Terms and Conditions');
      return;
    }
    final auth = context.read<AuthController>();
    final ok = await auth.register(
      name: _name.text.trim(),
      email: _email.text.trim(),
      password: _password.text,
      countryCode: _countryCode,
      mobile: _mobile.text.trim(),
    );
    if (!mounted) return;
    // if (ok) {
    //   Navigator.pushNamed(context, AppRoutes.otp,
    //       arguments: '$_countryCode ${_mobile.text.trim()}');
    // } else {
    //   showAppSnack(context, auth.error ?? 'Registration failed');
    // }
    if (ok) {
      final loggedIn = await auth.login(_email.text.trim(), _password.text);
      if (!mounted) return;
      if (!loggedIn) {
        showAppSnack(context, auth.error ?? 'Login failed');
        return;
      }
      final sent = await auth.sendOtp();
      if (!mounted) return;
      if (!sent) {
        showAppSnack(context, auth.error ?? 'Could not send OTP');
        return;
      }
      Navigator.pushNamed(context, AppRoutes.otp,
          arguments: '$_countryCode ${_mobile.text.trim()}');
    } else {
      showAppSnack(context, auth.error ?? 'Registration failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<AuthController>().isLoading;
    const gap = SizedBox(height: 20);
    const iconSize = 22.0;

    return AuthScaffold(
      buttonLabel: 'Sign Up',
      isLoading: loading,
      onPressed: _submit,
      footer: AuthFooterText(
        prefix: 'Already have an account?',
        actionLabel: 'Sign In',
        onAction: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Welcome!', style: AppTextStyles.heading),
            const SizedBox(height: 4),
            Text('Please register to continue', style: AppTextStyles.subtitle),
            const SizedBox(height: 24),
            AppTextField(
              hint: 'Name',
              controller: _name,
              validator: (v) => Validators.notEmpty(v, 'Name'),
              suffix: const Icon(Icons.person_outline, size: iconSize, color: AppColors.icon),
            ),
            gap,
            AppTextField(
              hint: 'Email address',
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              validator: Validators.email,
              suffix:  Icon(Icons.mail_outline, size: iconSize, color: AppColors.icon),
            ),
            gap,
            AppTextField(
              hint: 'Password',
              controller: _password,
              obscureText: true,
              validator: Validators.password,
              suffix:  Icon(Icons.lock_outline, size: iconSize, color: AppColors.icon),
            ),
            gap,
            AppTextField(
              hint: '',
              readOnly: true,
              onTap: () {}, // TODO: country picker
              prefix: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const IndiaFlag(),
                  const SizedBox(width: 8),
                  Text(_countryCode, style: AppTextStyles.inter(15)),
                ],
              ),
              suffix: const FaIcon(FontAwesomeIcons.whatsapp, size: iconSize, color: AppColors.icon),
            ),
            gap,
            AppTextField(
              hint: 'Mobile number',
              controller: _mobile,
              keyboardType: TextInputType.phone,
              validator: Validators.mobile,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              suffix: const Icon(Icons.smartphone_outlined, size: iconSize, color: AppColors.icon),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: TermsCheckbox(
                value: _agreed,
                onChanged: (v) => setState(() => _agreed = v),
                onTermsTap: () {}, // TODO: open terms
              ),
            ),
          ],
        ),
      ),
    );
  }
}
