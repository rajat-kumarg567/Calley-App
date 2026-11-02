import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../../../home/presentation/widgets/app_drawer.dart';
import '../../../home/presentation/widgets/home_app_bar.dart';
import '../../controllers/dashboard_controller.dart';
import '../widgets/dashboard_empty_view.dart';
import '../widgets/dashboard_loaded_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = context.read<AuthController>().user.userId;
      context.read<DashboardController>().load(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthController>().user;
    final dash = context.watch<DashboardController>();

    Widget body;
    if (dash.isLoading || (dash.data == null && dash.error == null)) {
      body = const Center(child: CircularProgressIndicator());
    } else if (dash.data == null) {
      body = Center(
        child: TextButton(
          onPressed: () => dash.load(user.userId),
          child: const Text('Something went wrong. Tap to retry'),
        ),
      );
    } else if (dash.data!.isEmpty && !dash.listSelected) {
      // No list chosen yet -> "Load number to call" screen
      body = DashboardEmptyView(userName: user.name);
    } else {
      // A list was chosen -> dashboard, even if every count is 0
      body = DashboardLoadedView(data: dash.data!, userInitial: user.initial);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
      appBar: const HomeAppBar(title: 'Dashboard'),
      body: body,
    );
  }
}
