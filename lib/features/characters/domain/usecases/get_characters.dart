import 'package:equatable/equatable.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/domain/repos/characters_repo.dart';
import 'package:mortygram/features/pagination/domain/entities/page_result.dart';

class GetCharacters {
  const GetCharacters(this._repo);

  final CharactersRepo _repo;

  ResultFuture<PaginatedResults<Character>> call(PaginatedGetCharactersParams params) {
    return _repo.getCharacters(page: params.page, keyword: params.keyword);
  }
}

class PaginatedGetCharactersParams extends Equatable {
  const PaginatedGetCharactersParams({
    required this.page,
    required this.keyword,
  });

  final String? keyword;
  final int page;

  @override
  List<Object?> get props => <Object?>[page, keyword];
}
