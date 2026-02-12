import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/pagination/domain/entities/page_result.dart';

abstract interface class CharactersRepo {
  Stream<PaginatedResults<Character>> watchCharacters({required int page, String? keyword});
  Future<void> syncCharacters({required int page});
}
