import 'package:flutter/material.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/dashboard/presentation/screens/getting_started_screen.dart';
import '../../features/home/presentation/screens/main_shell.dart';
import '../../features/language/presentation/screens/language_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String language = '/language';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String main = '/main';
  static const String settings = '/settings';
  static const String gettingStarted = '/getting-started';

  static Route<dynamic> onGenerateRoute(RouteSettings s) {
    final Widget page;
    switch (s.name) {
      case language:
        page = LanguageScreen(fromSettings: s.arguments == true);
        break;
      case login:
        page = const LoginScreen();
        break;
      case register:
        page = const RegisterScreen();
        break;
      case otp:
        page = OtpScreen(phone: (s.arguments as String?) ?? '');
        break;
      case main:
        page = const MainShell();
        break;
      case settings:
        page = const SettingsScreen();
        break;
      case gettingStarted:
        page = const GettingStartedScreen();
        break;
      default:
        page = const LoginScreen();
    }
    return MaterialPageRoute(builder: (_) => page, settings: s);
  }
}
