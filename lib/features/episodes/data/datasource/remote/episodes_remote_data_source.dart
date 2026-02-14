import 'package:dio/dio.dart';
import 'package:mortygram/config/logger/my_log.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/features/episodes/data/dtos/episode_dto.dart';

abstract interface class EpisodesRemoteDataSource {
  Future<EpisodeDto?> fetchEpisode({required String url});
}

class EpisodesRemoteDataSourceImpl implements EpisodesRemoteDataSource {
  const EpisodesRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<EpisodeDto?> fetchEpisode({required String url}) async {
    try {
      final Response<DataMap> response = await _dio.get<DataMap>(url);
      if (response.data != null) {
        return EpisodeDto.fromJson(response.data!);
      }
      return null;
    } on DioException catch (e) {
      myLog('Failed to fetch episode from $url: ${e.message}', level: .warning);
      return null;
    } catch (e) {
      myLog('Unexpected error fetching episode from $url: $e', level: .error);
      return null;
    }
  }
}
