import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/start_calling_bar.dart';
import '../../models/dashboard_data.dart';
import 'call_stat_card.dart';
import 'donut_chart.dart';
import 'list_summary_card.dart';

class DashboardLoadedView extends StatelessWidget {
  const DashboardLoadedView({super.key, required this.data, required this.userInitial});

  final DashboardData data;
  final String userInitial;

  @override
  Widget build(BuildContext context) {
    final s = data.stats;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Column(
        children: [
          ListSummaryCard(listName: data.listName, total: s.total, initial: userInitial),
          Expanded(
            child: Center(
              child: DonutChart(
                segments: [
                  DonutSegment(s.done.toDouble(), AppColors.chartBlue),
                  DonutSegment(s.scheduled.toDouble(), AppColors.chartPurple),
                  DonutSegment(s.pending.toDouble(), AppColors.chartOrange),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: CallStatCard(
                  label: 'Pending',
                  count: s.pending,
                  barColor: AppColors.pendingBar,
                  backgroundColor: AppColors.pendingBg,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CallStatCard(
                  label: 'Done',
                  count: s.done,
                  barColor: AppColors.doneBar,
                  backgroundColor: AppColors.doneBg,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CallStatCard(
                  label: 'Schedule',
                  count: s.scheduled,
                  barColor: AppColors.scheduleBar,
                  backgroundColor: AppColors.scheduleBg,
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          const StartCallingBar(),
        ],
      ),
    );
  }
}
