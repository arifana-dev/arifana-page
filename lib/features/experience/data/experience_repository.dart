import '../domain/experience_item.dart';

abstract class ExperienceRepository {
  List<ExperienceItem> getExperiences();
  EducationItem getEducation();
}

class ExperienceRepositoryImpl implements ExperienceRepository {
  const ExperienceRepositoryImpl();

  @override
  List<ExperienceItem> getExperiences() {
    return const [
      ExperienceItem(
        title: 'Mobile Developer',
        company: 'PT Inovasi Solusi Internasional',
        period: '2021 – Present',
        type: 'Full-time',
        bullets: [
          'Sole mobile developer using Flutter + Clean Architecture + GetX',
          'Integrated REST APIs and Firebase services (Auth, FCM, Realtime DB)',
          'Built BLE-enabled apps for IoT device control',
          'Managed full app lifecycle from development to deployment',
          'Collaborated closely with backend and IoT engineers',
        ],
      ),
      ExperienceItem(
        title: 'Mobile Developer',
        company: 'PT Xeranta Matra Solusi',
        period: '2020',
        type: 'Full-time',
        bullets: [
          'Developed and maintained Flutter mobile applications',
          'Fixed bugs and improved app stability',
          'Gained backend experience with Java Spring Boot',
        ],
      ),
      ExperienceItem(
        title: 'Freelance Mobile Developer',
        company: 'Self-employed',
        period: '2021 – 2024',
        type: 'Freelance',
        bullets: [
          'Built BLE-based hospital management systems',
          'Developed employee management and trading applications',
          'Delivered scalable, secure solutions on time',
        ],
      ),
    ];
  }

  @override
  EducationItem getEducation() {
    return const EducationItem(
      degree: 'Bachelor of Computer Science',
      institution: 'Universitas Nusa Mandiri',
      period: '2020 – 2025',
    );
  }
}
