import 'package:equatable/equatable.dart';

class ExperienceItem extends Equatable {
  const ExperienceItem({
    required this.title,
    required this.company,
    required this.period,
    required this.type,
    required this.bullets,
  });

  final String title;
  final String company;
  final String period;
  final String type;
  final List<String> bullets;

  @override
  List<Object?> get props => [title, company, period, type, bullets];
}

class EducationItem extends Equatable {
  const EducationItem({
    required this.degree,
    required this.institution,
    required this.period,
  });

  final String degree;
  final String institution;
  final String period;

  @override
  List<Object?> get props => [degree, institution, period];
}
