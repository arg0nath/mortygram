import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/features/pagination/domain/entities/pagination_meta.dart';

class PaginatedResults<T> {
  final List<T> results;
  final PaginationMeta info;

  PaginatedResults({
    required this.results,
    required this.info,
  });

  factory PaginatedResults.fromJson(DataMap json, T Function(DataMap) fromJsonT) {
    final List<T> results = (json['results'] as List).map((dynamic item) => fromJsonT(item as DataMap)).toList();
    return PaginatedResults(
      results: results,
      info: PaginationMeta.fromJson(json['info'] as DataMap),
    );
  }
}
