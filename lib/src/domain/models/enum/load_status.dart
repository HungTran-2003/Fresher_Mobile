enum LoadStatus {
  initial,
  loading,
  loadingMore,
  success,
  failure;

  bool get isInitial => this == LoadStatus.initial;
  bool get isLoading => this == LoadStatus.loading;
  bool get isLoadingMore => this == LoadStatus.loadingMore;
  bool get isSuccess => this == LoadStatus.success;
  bool get isFailure => this == LoadStatus.failure;
}
