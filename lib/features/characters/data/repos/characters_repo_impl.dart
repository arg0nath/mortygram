// ignore_for_file: always_specify_types

import 'package:dartz/dartz.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/core/common/errors/exceptions.dart';
import 'package:mortygram/core/common/errors/failures.dart';
import 'package:mortygram/features/characters/data/datasource/local/characters_local_data_source.dart';
import 'package:mortygram/features/characters/data/datasource/remote/characters_remote_data_source.dart';
import 'package:mortygram/features/characters/data/dtos/character_dto.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/domain/repos/characters_repo.dart';
import 'package:mortygram/features/pagination/domain/entities/page_result.dart';
import 'package:mortygram/features/pagination/domain/entities/pagination_meta.dart';

class CharactersRepoImpl implements CharactersRepo {
  const CharactersRepoImpl(
    this._remote,
    this._local,
  );

  final CharactersRemoteDataSource _remote;
  final CharactersLocalDataSource _local;

  @override
  ResultFuture<PaginatedResults<Character>> getCharacters({required int page, String? keyword}) async {
    //i choose this approcah to skip local db when searching because it adds complexity to the local data source
    //so skip local DB when searching - always fetch from API with search query
    final bool isSearching = keyword != null && keyword.isNotEmpty;

    if (!isSearching) {
      // try to get from local DB (non search case)
      final List<CharacterDto> localCharacters = await _local.getCharacters(page);
      final PaginationMeta? localMeta = await _local.getPaginationMeta(AppConst.charactersApiUrl, page);

      // if cached data exists
      if (localCharacters.isNotEmpty && localMeta != null) {
        final List<Character> characters = localCharacters.map((CharacterDto e) => e.toEntity()).toList();
        return Right(PaginatedResults(results: characters, info: localMeta));
      }
    }

    // fetch from API (for search or when not cached)
    try {
      final PaginatedResults<CharacterDto> remoteResult = await _remote.fetchCharacters(page: page, keyword: keyword);

      // cache characters and pagination metadata (only for non-search)
      if (!isSearching) {
        await _local.cacheCharacters(remoteResult.results);
        await _local.cachePaginationMeta(AppConst.charactersApiUrl, page, remoteResult.info);
      }

      final List<Character> characters = remoteResult.results.map((CharacterDto e) => e.toEntity()).toList();
      return Right(PaginatedResults(results: characters, info: remoteResult.info));
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 500));
    }
  }
}
