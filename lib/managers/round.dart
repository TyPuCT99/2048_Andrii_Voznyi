import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoundManager extends StateNotifier<bool> {
  RoundManager() : super(true);

  void end() {
    state = true;
  }

  void begin() {
    state = false;
  }
}

final roundManager = StateNotifierProvider<RoundManager, bool>((ref) {
  return RoundManager();
});
