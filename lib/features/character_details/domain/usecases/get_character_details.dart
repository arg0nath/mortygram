import 'package:equatable/equatable.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/config/usecase/usecase.dart';
import 'package:mortygram/features/character_details/domain/entities/character_details.dart';
import 'package:mortygram/features/character_details/domain/repos/character_details_repo.dart';

class GetCharacterDetails extends UseCaseWithParams<CharacterDetails, GetCharacterDetailsParams> {
  const GetCharacterDetails(this._repo);

  final CharacterDetailsRepo _repo;

  @override
  ResultFuture<CharacterDetails> call(GetCharacterDetailsParams params) async => _repo.getCharacterDetails(characterId: params.characterId);
}

class GetCharacterDetailsParams extends Equatable {
  const GetCharacterDetailsParams({
    required this.characterId,
  });

  final int characterId;

  @override
  List<Object?> get props => <Object?>[characterId];
}
