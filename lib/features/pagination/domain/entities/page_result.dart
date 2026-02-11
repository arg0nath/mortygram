class PaginatedResults<T> {
  final List<T> items;
  final int currentPage;
  final int lastPage;

  PaginatedResults({
    required this.items,
    required this.currentPage,
    required this.lastPage,
  });

  bool get isLastPage => currentPage >= lastPage;
}
