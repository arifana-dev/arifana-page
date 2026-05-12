import 'package:equatable/equatable.dart';

class ProjectItem extends Equatable {
  const ProjectItem({
    required this.id,
    required this.title,
    required this.description,
    required this.role,
    required this.period,
    required this.tags,
    required this.highlights,
    required this.isPublished,
    required this.sortOrder,
  });

  final String id;
  final String title;
  final String description;
  final String role;
  final String period;
  final List<String> tags;
  final List<String> highlights;
  final bool isPublished;
  final int sortOrder;

  ProjectItem copyWith({
    String? id,
    String? title,
    String? description,
    String? role,
    String? period,
    List<String>? tags,
    List<String>? highlights,
    bool? isPublished,
    int? sortOrder,
  }) {
    return ProjectItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      role: role ?? this.role,
      period: period ?? this.period,
      tags: tags ?? this.tags,
      highlights: highlights ?? this.highlights,
      isPublished: isPublished ?? this.isPublished,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        role,
        period,
        tags,
        highlights,
        isPublished,
        sortOrder,
      ];
}
