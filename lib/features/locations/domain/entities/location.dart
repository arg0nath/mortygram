import 'package:equatable/equatable.dart';

class Location extends Equatable {
  const Location({
    required this.name,
    required this.url,
  });

  final String name, url;

  @override
  List<Object?> get props => <Object?>[name, url];

  @override
  String toString() => 'Location(name: $name, url: $url)';
}
