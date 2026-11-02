import '../../core/routes/app_routes.dart';

import 'package:calley_app/shared/widgets/whatsapp_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/utils/ui_helpers.dart';
import '../../features/auth/controllers/auth_controller.dart';
import '../../features/dashboard/controllers/dashboard_controller.dart';
import '../../features/settings/presentation/widgets/calling_lists_sheet.dart';
import 'app_button.dart';

class StartCallingBar extends StatelessWidget {
  const StartCallingBar({super.key, this.showWhatsApp = false});
  final bool showWhatsApp;

  Future<void> _onStartCalling(BuildContext context) async {
    // Grab these first, because this screen may be closed below.
    final userId = context.read<AuthController>().user.userId;
    final dashboard = context.read<DashboardController>();
    final navigator = Navigator.of(context);

    final list = await showCallingListsSheet(context);
    if (list == null) return;

    // If we were on the Getting Started page, go back to the dashboard.
    navigator.popUntil(
          (route) => route.settings.name == AppRoutes.main || route.isFirst,
    );

    dashboard.load(userId, listId: list.id, listName: list.name);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showWhatsApp) ...[
          WhatsAppButton(onPressed: () => showAppSnack(context, 'Opening WhatsApp...')),
          const SizedBox(width: 10),
        ],
        Expanded(
          child: AppButton(
            label: 'Start Calling Now',
            onPressed: () => _onStartCalling(context),
          ),
        ),
      ],
    );
  }
}
