import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/pagination/domain/entities/page_result.dart';

abstract interface class CharactersRepo {
  ResultFuture<PaginatedResults<Character>> getCharacters({
    required int page,
    String? keyword,
    String? genderFilter,
    String? statusFilter,
  });
}
