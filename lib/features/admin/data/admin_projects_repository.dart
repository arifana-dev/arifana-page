import 'package:cloud_firestore/cloud_firestore.dart';

import '../../projects/domain/project_item.dart';

abstract class AdminProjectsRepository {
  Stream<List<ProjectItem>> watchProjects();
  Future<void> createProject(ProjectItem project);
  Future<void> updateProject(ProjectItem project);
  Future<void> deleteProject(String id);
}

class AdminProjectsRepositoryImpl implements AdminProjectsRepository {
  AdminProjectsRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('projects');

  @override
  Stream<List<ProjectItem>> watchProjects() {
    return _collection
        .orderBy('sortOrder')
        .snapshots()
        .map((snapshot) => snapshot.docs.map(_fromDoc).toList());
  }

  @override
  Future<void> createProject(ProjectItem project) {
    return _collection.add({
      ..._toFirestore(project),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> updateProject(ProjectItem project) {
    return _collection.doc(project.id).update({
      ..._toFirestore(project),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> deleteProject(String id) {
    return _collection.doc(id).delete();
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

  static Map<String, Object?> _toFirestore(ProjectItem project) {
    return {
      'title': project.title,
      'description': project.description,
      'role': project.role,
      'period': project.period,
      'tags': project.tags,
      'highlights': project.highlights,
      'isPublished': project.isPublished,
      'sortOrder': project.sortOrder,
    };
  }
}
