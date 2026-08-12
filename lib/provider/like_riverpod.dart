import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikeNotifier extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void like() {
    state++;
  }

  void unlike() {
    if (state > 0) {
      state--;
    }
  }
}

final likeProvider = NotifierProvider<LikeNotifier, int>(LikeNotifier.new);
