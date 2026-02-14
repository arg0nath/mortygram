import 'package:equatable/equatable.dart';
import 'package:mortygram/features/locations/domain/entities/location.dart';
import 'package:mortygram/features/origins/domain/entities/origin.dart';

class Character extends Equatable {
  const Character({
    required this.id,
    required this.location,
    required this.name,
    required this.image,
    required this.status,
    required this.species,
    required this.origin,
    required this.type,
    required this.episode,
    required this.gender,
    this.firstEpisodeName,
  });

  final int id;
  final String name, image, status, species, type, gender;
  final List<String> episode;
  final String? firstEpisodeName;
  final Location location;
  final Origin origin;

  @override
  List<Object?> get props => <Object?>[id, name, image];

  @override
  String toString() => 'Character(id: $id, name: $name, imageUrl: $image)';
}
