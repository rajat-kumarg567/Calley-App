class CallStats {
  const CallStats({
    required this.total,
    required this.pending,
    required this.done,
    required this.scheduled,
  });

  final int total;
  final int pending;
  final int done;
  final int scheduled;
}

class DashboardData {
  const DashboardData({required this.listName, required this.stats});

  final String listName;
  final CallStats stats;

  /// No numbers uploaded yet -> show the "Load number to call" state.
  bool get isEmpty => stats.total == 0;
}
