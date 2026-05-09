import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../exceptions/failure.dart';
import 'paginated_state.dart';

/// Page payload returned by a [PageFetcher]. Includes the items for this
/// page plus the cursor required to fetch the *next* page (`null` indicates
/// there are no further pages).
class Page<T> {
  const Page({required this.items, this.nextCursor});
  final List<T> items;
  final String? nextCursor;
}

typedef PageFetcher<T> = Future<Either<Failure, Page<T>>> Function(
  String? cursor,
);

/// Reusable base for cursor-paginated `AsyncNotifier`s. Concrete feature
/// notifiers extend this and supply a [fetchPage] implementation; consumers
/// call [loadMore] when the user scrolls past `loadMoreThreshold`.
///
/// State semantics:
/// - First load: `state = AsyncLoading` while `fetchPage(null)` is in flight.
/// - Subsequent pages: `state.value.isLoadingMore = true`; the page items are
///   appended on success.
/// - End of list: `hasReachedEnd = true` once a page returns a `null` cursor.
/// - Failure: stored on `state.value.error` (does not throw `AsyncError`,
///   which would discard the items already loaded).
abstract class PaginatedAsyncNotifier<T>
    extends AsyncNotifier<PaginatedState<T>> {
  /// Provided by the subclass — fetches a single page given the cursor.
  Future<Either<Failure, Page<T>>> fetchPage(String? cursor);

  @override
  Future<PaginatedState<T>> build() async {
    final result = await fetchPage(null);
    return result.fold(
      (failure) => PaginatedState<T>(error: failure),
      (page) => PaginatedState<T>(
        items: page.items,
        nextCursor: page.nextCursor,
        hasReachedEnd: page.nextCursor == null,
      ),
    );
  }

  Future<void> loadMore() async {
    final current = state.whenOrNull(data: (s) => s);
    if (current == null || !current.canLoadMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true, error: null));

    final result = await fetchPage(current.nextCursor);
    final next = result.fold(
      (failure) => current.copyWith(isLoadingMore: false, error: failure),
      (page) => current.copyWith(
        items: [...current.items, ...page.items],
        nextCursor: page.nextCursor,
        hasReachedEnd: page.nextCursor == null,
        isLoadingMore: false,
        error: null,
      ),
    );
    state = AsyncData(next);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(build);
  }
}
