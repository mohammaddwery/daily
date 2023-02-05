class TaskTimer {
  Duration duration;
  String formatDuration;
  bool playing;
  TaskTimer({
    this.duration=const Duration(seconds: 0),
    this.formatDuration='00:00:00',
    this.playing=false,
  });

  TaskTimer copy({
    Duration? duration,
    String? formatDuration,
    bool? playing,
  }) => TaskTimer(
    duration: duration??this.duration,
    formatDuration: formatDuration??this.formatDuration,
    playing: playing??this.playing,
  );
}