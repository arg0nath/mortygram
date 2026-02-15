import 'package:equatable/equatable.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/config/usecase/usecase.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/domain/entities/character_search_filters.dart';
import 'package:mortygram/features/characters/domain/repos/characters_repo.dart';
import 'package:mortygram/features/pagination/domain/entities/page_result.dart';

class GetCharacters extends UseCaseWithParams<PaginatedResults<Character>, GetCharactersParams> {
  const GetCharacters(this._repo);

  final CharactersRepo _repo;

  @override
  ResultFuture<PaginatedResults<Character>> call(GetCharactersParams params) {
    return _repo.getCharacters(
      page: params.page,
      keyword: params.filters.keyword,
      genderFilter: params.filters.gender,
      statusFilter: params.filters.status,
    );
  }
}

class GetCharactersParams extends Equatable {
  const GetCharactersParams({
    required this.page,
    this.filters = const CharacterSearchFilters(),
  });

  final CharacterSearchFilters filters;
  final int page;

  @override
  List<Object?> get props => <Object?>[page, filters];
}
