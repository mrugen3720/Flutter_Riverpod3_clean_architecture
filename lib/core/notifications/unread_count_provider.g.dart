// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unread_count_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// In-app unread notification badge count.
///
/// Replaces the legacy `showUnreadNotificationCount` ValueNotifier global.
/// Once a notifications feature module exists, this provider should move to
/// `lib/features/notifications/` and back its state with the real source
/// (push events, cache, server fetch).

@ProviderFor(UnreadCount)
final unreadCountProvider = UnreadCountProvider._();

/// In-app unread notification badge count.
///
/// Replaces the legacy `showUnreadNotificationCount` ValueNotifier global.
/// Once a notifications feature module exists, this provider should move to
/// `lib/features/notifications/` and back its state with the real source
/// (push events, cache, server fetch).
final class UnreadCountProvider extends $NotifierProvider<UnreadCount, int> {
  /// In-app unread notification badge count.
  ///
  /// Replaces the legacy `showUnreadNotificationCount` ValueNotifier global.
  /// Once a notifications feature module exists, this provider should move to
  /// `lib/features/notifications/` and back its state with the real source
  /// (push events, cache, server fetch).
  UnreadCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unreadCountProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unreadCountHash();

  @$internal
  @override
  UnreadCount create() => UnreadCount();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$unreadCountHash() => r'f1059327a173214b28715666d58dacf708f09a72';

/// In-app unread notification badge count.
///
/// Replaces the legacy `showUnreadNotificationCount` ValueNotifier global.
/// Once a notifications feature module exists, this provider should move to
/// `lib/features/notifications/` and back its state with the real source
/// (push events, cache, server fetch).

abstract class _$UnreadCount extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
