import 'package:equatable/equatable.dart';

class HeroInfo extends Equatable {
  const HeroInfo({
    required this.greeting,
    required this.name,
    required this.role,
    required this.tagline,
    required this.location,
  });

  final String greeting;
  final String name;
  final String role;
  final String tagline;
  final String location;

  @override
  List<Object?> get props => [greeting, name, role, tagline, location];
}
