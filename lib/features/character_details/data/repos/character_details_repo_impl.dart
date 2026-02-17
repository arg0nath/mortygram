// ignore_for_file: always_specify_types

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/core/common/errors/failures.dart';
import 'package:mortygram/features/character_details/data/datasource/local/character_details_local_data_source.dart';
import 'package:mortygram/features/character_details/data/datasource/remote/character_details_remote_data_source.dart';
import 'package:mortygram/features/character_details/data/dtos/character_details_dto.dart';
import 'package:mortygram/features/character_details/domain/entities/character_details.dart';
import 'package:mortygram/features/character_details/domain/repos/character_details_repo.dart';

class CharacterDetailsRepoImpl implements CharacterDetailsRepo {
  const CharacterDetailsRepoImpl(
    this._remote,
    this._local,
  );

  final CharacterDetailsRemoteDataSource _remote;
  final CharacterDetailsLocalDataSource _local;

  @override
  ResultFuture<CharacterDetails> getCharacterDetails({required int characterId}) async {
    // try to get from local DB
    final CharacterDetailsDto? localCharacterDetails = await _local.getCharacterDetails(characterId);

    // ff cached data exists
    if (localCharacterDetails != null) {
      final CharacterDetails character = localCharacterDetails.toEntity();
      return Right((character));
    }

    //not cached - fetch from API
    try {
      final CharacterDetailsDto remoteResult = await _remote.fetchCharacterDetails(characterId: characterId);

      // Cache  character details
      await _local.cacheCharacterDetails(remoteResult);

      final CharacterDetails characterDetails = remoteResult.toEntity();
      return Right(characterDetails);
    } on DioException catch (e) {
      return Left(ApiFailure.fromException(e));
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 500));
    }
  }
}
