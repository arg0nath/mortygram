import 'package:equatable/equatable.dart';

class Character extends Equatable {
  const Character({required this.id, required this.name, required this.imageUrl, required this.status, required this.species, required this.type, required this.episode, required this.gender});

  final int id;
  final String name, imageUrl, status, species, type, gender;
  final List<String> episode;

  @override
  List<Object?> get props => <Object?>[id, name, imageUrl];

  @override
  String toString() => 'Character(id: $id, name: $name, imageUrl: $imageUrl)';
}
