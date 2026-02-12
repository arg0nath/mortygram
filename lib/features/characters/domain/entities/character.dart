import 'package:equatable/equatable.dart';

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
  });

  final int id;
  final String name, image, status, species, type, gender;
  final List<String> episode;
  final List<String> location;
  final List<String> origin;

  @override
  List<Object?> get props => <Object?>[id, name, image];

  @override
  String toString() => 'Character(id: $id, name: $name, imageUrl: $image)';
}
