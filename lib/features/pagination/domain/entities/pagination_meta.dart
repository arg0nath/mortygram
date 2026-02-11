import 'package:mortygram/config/typedefs/typedefs.dart';

class PaginationMeta {
  PaginationMeta({required this.count, required this.pages, required this.next, required this.prev});

  final int count, pages;
  final String? next, prev;

  factory PaginationMeta.fromJson(DataMap json) {
    return PaginationMeta(count: json['count'] as int, pages: json['pages'] as int, next: json['next'] as String?, prev: json['prev'] as String?);
  }
}
