import '../../../core/constants/app_strings.dart';
import '../domain/about_info.dart';

abstract class AboutRepository {
  AboutInfo getAboutInfo();
}

class AboutRepositoryImpl implements AboutRepository {
  const AboutRepositoryImpl();

  @override
  AboutInfo getAboutInfo() {
    return const AboutInfo(
      bio: AppStrings.aboutBio,
      highlights: [
        '4+ years of Flutter experience',
        'Sole mobile developer, end-to-end delivery',
        'Published apps on Play Store & App Store',
        'BLE-enabled IoT mobile solutions',
      ],
      languages: [
        LanguageProficiency(name: 'Bahasa Indonesia', level: 'Native'),
        LanguageProficiency(name: 'English', level: 'Professional'),
      ],
    );
  }
}
