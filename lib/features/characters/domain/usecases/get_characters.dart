import 'package:equatable/equatable.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/config/usecase/usecase.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/domain/repos/characters_repo.dart';
import 'package:mortygram/features/pagination/domain/entities/page_result.dart';

class GetCharacters extends UseCaseWithParams<PaginatedResults<Character>, GetCharactersParams> {
  const GetCharacters(this._repo);

  final CharactersRepo _repo;

  @override
  ResultFuture<PaginatedResults<Character>> call(GetCharactersParams params) {
    return _repo.getCharacters(page: params.page, keyword: params.keyword);
  }
}

class GetCharactersParams extends Equatable {
  const GetCharactersParams({
    required this.page,
    required this.keyword,
    required this.statusFilter,
    required this.genderFilter,
  });

  final String? keyword, genderFilter, statusFilter;
  final int page;

  @override
  List<Object?> get props => <Object?>[page, keyword, genderFilter, statusFilter];
}
