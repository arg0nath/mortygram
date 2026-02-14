import 'package:equatable/equatable.dart';

class Origin extends Equatable {
  const Origin({
    required this.name,
    required this.url,
  });

  final String name, url;

  @override
  List<Object?> get props => <Object?>[name, url];

  @override
  String toString() => 'Origin(name: $name, url: $url)';
}
