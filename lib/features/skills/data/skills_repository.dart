import '../domain/skill_category.dart';

abstract class SkillsRepository {
  List<SkillCategory> getSkills();
}

class SkillsRepositoryImpl implements SkillsRepository {
  const SkillsRepositoryImpl();

  @override
  List<SkillCategory> getSkills() {
    return const [
      SkillCategory(
        name: 'Languages & Frameworks',
        skills: ['Dart', 'Flutter', 'Java Spring Boot'],
      ),
      SkillCategory(
        name: 'State Management & Architecture',
        skills: ['GetX', 'BLoC', 'Clean Architecture', 'MVVM'],
      ),
      SkillCategory(
        name: 'Networking',
        skills: ['REST API', 'HTTP', 'Dio', 'Postman'],
      ),
      SkillCategory(
        name: 'Firebase',
        skills: [
          'Firebase Auth',
          'FCM',
          'Realtime Database',
          'Firebase Analytics',
        ],
      ),
      SkillCategory(
        name: 'Hardware & IoT',
        skills: ['BLE Integration', 'IoT Device Control'],
      ),
      SkillCategory(
        name: 'Tools & Workflow',
        skills: [
          'Git',
          'Appium',
          'Figma',
          'Performance Optimization',
          'Play Store Deployment',
          'App Store Deployment',
        ],
      ),
    ];
  }
}
