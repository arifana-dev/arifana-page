import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/project_item.dart';

abstract class ProjectsRepository {
  Stream<List<ProjectItem>> watchPublishedProjects();
}

class ProjectsRepositoryImpl implements ProjectsRepository {
  ProjectsRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Stream<List<ProjectItem>> watchPublishedProjects() {
    return _firestore
        .collection('projects')
        .where('isPublished', isEqualTo: true)
        .orderBy('sortOrder')
        .snapshots()
        .map((snapshot) => snapshot.docs.map(_fromDoc).toList());
  }

  static ProjectItem _fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return ProjectItem(
      id: doc.id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      role: data['role'] as String? ?? '',
      period: data['period'] as String? ?? '',
      tags: List<String>.from(data['tags'] as List? ?? const []),
      highlights: List<String>.from(data['highlights'] as List? ?? const []),
      isPublished: data['isPublished'] as bool? ?? false,
      sortOrder: (data['sortOrder'] as num?)?.toInt() ?? 0,
    );
  }
}
