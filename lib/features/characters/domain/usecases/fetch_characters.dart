import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/config/usecase/usecase.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/domain/repos/characters_repo.dart';

class FetchCharacters extends UseCaseWithoutParams<List<Character>> {
  const FetchCharacters(this._charactersRepo);

  final CharactersRepo _charactersRepo;

  @override
  ResultFuture<List<Character>> call() async => _charactersRepo.fetchCharacters();
}
