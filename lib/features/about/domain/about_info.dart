import 'package:equatable/equatable.dart';

class AboutInfo extends Equatable {
  const AboutInfo({
    required this.bio,
    required this.highlights,
    required this.languages,
  });

  final String bio;
  final List<String> highlights;
  final List<LanguageProficiency> languages;

  @override
  List<Object?> get props => [bio, highlights, languages];
}

class LanguageProficiency extends Equatable {
  const LanguageProficiency({required this.name, required this.level});

  final String name;
  final String level;

  @override
  List<Object?> get props => [name, level];
}
