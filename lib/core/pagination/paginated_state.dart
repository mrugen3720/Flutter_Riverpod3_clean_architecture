import 'package:freezed_annotation/freezed_annotation.dart';

import '../exceptions/failure.dart';

part 'paginated_state.freezed.dart';

/// Generic state for a cursor-paginated list. Items accumulate across pages;
/// `nextCursor` is whatever opaque pointer the data source needs to fetch the
/// next page (typically the `next` URL from the project's `ApiResponse.links`).
@Freezed(genericArgumentFactories: true)
abstract class PaginatedState<T> with _$PaginatedState<T> {
  const factory PaginatedState({
    @Default(<Never>[]) List<T> items,
    String? nextCursor,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasReachedEnd,
    Failure? error,
  }) = _PaginatedState<T>;

  const PaginatedState._();

  bool get isFirstLoad => items.isEmpty && !hasReachedEnd && error == null;
  bool get canLoadMore => !hasReachedEnd && !isLoadingMore;
}
