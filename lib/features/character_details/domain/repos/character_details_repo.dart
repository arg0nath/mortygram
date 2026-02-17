import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/features/character_details/domain/entities/character_details.dart';

abstract interface class CharacterDetailsRepo {
  const CharacterDetailsRepo();

  ResultFuture<CharacterDetails> getCharacterDetails({required int characterId});
}
