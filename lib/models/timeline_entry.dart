class TimelineEntry {
  const TimelineEntry({
    required this.title,
    required this.organization,
    required this.period,
    this.details = const [],
  });

  final String title;
  final String organization;
  final String period;
  final List<String> details;
}
