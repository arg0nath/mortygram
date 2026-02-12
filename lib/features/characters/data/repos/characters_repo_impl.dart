import 'package:mortygram/features/characters/data/datasource/local/characters_local_data_source.dart';
import 'package:mortygram/features/characters/data/datasource/remote/characters_remote_data_source.dart';
import 'package:mortygram/features/characters/data/dtos/character_dto.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/domain/repos/characters_repo.dart';
import 'package:mortygram/features/pagination/domain/entities/page_result.dart';

class CharactersRepoImpl implements CharactersRepo {
  const CharactersRepoImpl(
    this._remote,
    this._local,
  );

  final CharactersRemoteDataSource _remote;
  final CharactersLocalDataSource _local;

  @override
  Stream<PaginatedResults<Character>> watchCharacters({required int page, String? keyword}) {
    return _local.watchCharacters(page).map(
      (List<CharacterDto> dtos) {
        final List<Character> characters = dtos.map((CharacterDto e) => e.toEntity()).toList();

        return PaginatedResults(
          items: characters,
          currentPage: page,
          lastPage: 42, // store properly later
        );
      },
    );
  }

  @override
  Future<void> syncCharacters({int page = 1}) async {
    try {
      final List<CharacterDto> remoteResult = await _remote.fetchCharacters(page: page);
      await _local.cacheCharacters(remoteResult);
    } catch (_) {
      // silent fail for offline
    }
  }
}
