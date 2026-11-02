// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/theme/app_text_styles.dart';
// import '../../../../shared/widgets/arrow_box_icon.dart';
// import '../../controllers/settings_controller.dart';
//
// Future<void> showCallingListsSheet(BuildContext context) {
//   return showModalBottomSheet<void>(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (_) => const _CallingListsSheet(),
//   );
// }
//
// class _CallingListsSheet extends StatelessWidget {
//   const _CallingListsSheet();
//
//   @override
//   Widget build(BuildContext context) {
//     final c = context.watch<SettingsController>();
//
//     return Container(
//       decoration: const BoxDecoration(
//         color: AppColors.navy,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             child: Text('CALLING LISTS',
//                 style: AppTextStyles.inter(15,
//                     weight: FontWeight.w700, color: Colors.white)),
//           ),
//           Container(
//             width: double.infinity,
//             padding: EdgeInsets.fromLTRB(
//                 30, 30, 30, 30 + MediaQuery.of(context).padding.bottom),
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
//                   decoration: BoxDecoration(
//                     color: AppColors.surfaceTint,
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Text('Select Calling List',
//                             style: AppTextStyles.inter(15, weight: FontWeight.w600)),
//                       ),
//                       ElevatedButton.icon(
//                         onPressed: c.isLoading ? null : c.refresh,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.primary,
//                           foregroundColor: Colors.white,
//                           elevation: 0,
//                           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8)),
//                         ),
//                         icon: c.isLoading
//                             ? const SizedBox(
//                           width: 18,
//                           height: 18,
//                           child: CircularProgressIndicator(
//                               strokeWidth: 2, color: Colors.white),
//                         )
//                             : const Icon(Icons.sync, size: 20),
//                         label: Text('Refresh',
//                             style: AppTextStyles.inter(14,
//                                 weight: FontWeight.w600, color: Colors.white)),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 ...c.lists.map(
//                       (l) => Padding(
//                     padding: const EdgeInsets.only(bottom: 12),
//                     child: Material(
//                       color: AppColors.surfaceTint,
//                       borderRadius: BorderRadius.circular(14),
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(14),
//                         onTap: () {
//                           c.select(l);
//                           Navigator.pop(context);
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: Text(l.name,
//                                     style: AppTextStyles.inter(15, weight: FontWeight.w600)),
//                               ),
//                               const ArrowBoxIcon(),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/arrow_box_icon.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../models/calling_list.dart';

/// Opens the sheet. Returns the list the user tapped, or null if dismissed.
Future<CallingList?> showCallingListsSheet(BuildContext context) {
  return showModalBottomSheet<CallingList>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _CallingListsSheet(),
  );
}

class _CallingListsSheet extends StatefulWidget {
  const _CallingListsSheet();

  @override
  State<_CallingListsSheet> createState() => _CallingListsSheetState();
}

class _CallingListsSheetState extends State<_CallingListsSheet> {
  @override
  void initState() {
    super.initState();
    // Load the real lists from the API every time the sheet opens.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = context.read<AuthController>().user.userId;
      context.read<SettingsController>().load(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<SettingsController>();

    Widget listArea;
    if (c.isLoading && c.lists.isEmpty) {
      listArea = const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (c.lists.isEmpty) {
      listArea = Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Text('No calling lists found',
            style: AppTextStyles.inter(14, color: AppColors.subtitle)),
      );
    } else {
      listArea = Column(
        children: c.lists
            .map(
              (l) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Material(
              color: AppColors.surfaceTint,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {
                  c.select(l);
                  Navigator.pop(context, l); // hand the tapped list back
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(l.name,
                            style: AppTextStyles.inter(15, weight: FontWeight.w600)),
                      ),
                      const ArrowBoxIcon(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
            .toList(),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text('CALLING LISTS',
                style: AppTextStyles.inter(15,
                    weight: FontWeight.w700, color: Colors.white)),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
                30, 30, 30, 30 + MediaQuery.of(context).padding.bottom),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceTint,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Select Calling List',
                            style: AppTextStyles.inter(15, weight: FontWeight.w600)),
                      ),
                      ElevatedButton.icon(
                        onPressed: c.isLoading ? null : c.refresh,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        icon: c.isLoading
                            ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                            : const Icon(Icons.sync, size: 20),
                        label: Text('Refresh',
                            style: AppTextStyles.inter(14,
                                weight: FontWeight.w600, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                listArea,
              ],
            ),
          ),
        ],
      ),
    );
  }
}