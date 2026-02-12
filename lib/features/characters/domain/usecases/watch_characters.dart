import 'package:equatable/equatable.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/domain/repos/characters_repo.dart';
import 'package:mortygram/features/pagination/domain/entities/page_result.dart';

class WatchCharacters {
  const WatchCharacters(this._repo);

  final CharactersRepo _repo;

  Stream<PaginatedResults<Character>> call(PaginatedWatchCharactersParams params) {
    // Triggers a background sync and returns reactive DB stream
    _repo.syncCharacters(page: params.page);
    return _repo.watchCharacters(page: params.page, keyword: params.keyword);
  }
}

class PaginatedWatchCharactersParams extends Equatable {
  const PaginatedWatchCharactersParams({
    required this.page,
    required this.keyword,
  });

  final String? keyword;
  final int page;

  @override
  List<Object?> get props => <Object?>[page, keyword];
}
