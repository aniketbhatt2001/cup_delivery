import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/notification_model.dart';

class NotificationStateNotifier extends StateNotifier<NotificationModel> {
  NotificationStateNotifier(super.state);

  updateNotificationCount() {
    state = state.copyWith(count: state.count! + 1);

    // notificationModel!.count = notificationModel!.count! + 1;

    // notifyListeners();
  }

  setState(NotificationModel notificationModel) {
    state = notificationModel;
  }

  resetNotificationCount() {
    state = state.copyWith(count: 0);
  }

  setCount(int count) {
    state = state.copyWith(count: count);
  }

  decrementCount() {
    if (state.count! > 0) {
      state = state.copyWith(count: state.count! - 1);
    }
  }
}
