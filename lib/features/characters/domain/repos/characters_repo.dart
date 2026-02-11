import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';

abstract interface class CharactersRepo {
  const CharactersRepo();

  ResultFuture<List<Character>> fetchCharacters();
}
