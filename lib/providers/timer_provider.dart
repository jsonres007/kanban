import 'package:flutter/foundation.dart';

class TimerProvider with ChangeNotifier {
  Map<String, Stopwatch> _timers = {};

  void startTimer(String taskId) {
    if (_timers.containsKey(taskId)) {
      _timers[taskId]!.start();
    } else {
      _timers[taskId] = Stopwatch()..start();
    }
    notifyListeners();
  }

  void stopTimer(String taskId) {
    _timers[taskId]?.stop();
    notifyListeners();
  }

  Duration getTime(String taskId) {
    return _timers[taskId]?.elapsed ?? Duration.zero;
  }

  // Additional methods for managing timers
}
