import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'unread_count_provider.g.dart';

/// In-app unread notification badge count.
///
/// Replaces the legacy `showUnreadNotificationCount` ValueNotifier global.
/// Once a notifications feature module exists, this provider should move to
/// `lib/features/notifications/` and back its state with the real source
/// (push events, cache, server fetch).
@Riverpod(keepAlive: true)
class UnreadCount extends _$UnreadCount {
  @override
  int build() => 0;

  void set(int value) => state = value;
  void increment() => state = state + 1;
  void clear() => state = 0;
}
