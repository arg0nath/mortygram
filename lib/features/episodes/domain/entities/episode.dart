import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  const Episode({
    required this.id,
    required this.name,
    required this.url,
    required this.episode,
  });

  final int id;
  final String name, url, episode;

  @override
  List<Object?> get props => <Object?>[id, name, url, episode];

  @override
  String toString() => 'Episode(name: $name, id: $id)';
}
