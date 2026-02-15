import 'package:dio/dio.dart';
import 'package:mortygram/config/logger/my_log.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/features/episodes/data/dtos/episode_dto.dart';

abstract interface class EpisodesRemoteDataSource {
  Future<dynamic> fetchEpisodes({required List<int> ids});
}

class EpisodesRemoteDataSourceImpl implements EpisodesRemoteDataSource {
  const EpisodesRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<dynamic> fetchEpisodes({required List<int> ids}) async {
    if (ids.isEmpty) return null;

    final String url = '${AppConst.characterEpisodeApiUrl}/${ids.join(',')}';

    try {
      final Response<dynamic> response = await _dio.get(url);
      if (response.data != null) {
        if (response.data is List) {
          // If multiple episodes are returned, return the first one (or handle as needed)
          final List<dynamic> dataList = response.data as List;
          final List<EpisodeDto> res = [];
          for (final dynamic data in dataList) {
            if (data is DataMap) {
              res.add(EpisodeDto.fromJson(data));
            }
          }
          return res;
        } else if (response.data is DataMap) {
          // If a single episode is returned
          return EpisodeDto.fromJson(response.data as DataMap);
        }
      }
      return null;
    } on DioException catch (e) {
      myLog('Failed to fetch episodes from $url: ${e.message}', level: .warning);
      return null;
    } catch (e) {
      myLog('Unexpected error fetching episodes from $url: $e', level: .error);
      return null;
    }
  }
}
