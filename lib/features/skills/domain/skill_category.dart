import 'package:equatable/equatable.dart';

class SkillCategory extends Equatable {
  const SkillCategory({required this.name, required this.skills});

  final String name;
  final List<String> skills;

  @override
  List<Object?> get props => [name, skills];
}
