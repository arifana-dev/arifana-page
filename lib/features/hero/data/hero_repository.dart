import '../domain/hero_info.dart';
import '../../../core/constants/app_strings.dart';

abstract class HeroRepository {
  HeroInfo getHeroInfo();
}

class HeroRepositoryImpl implements HeroRepository {
  const HeroRepositoryImpl();

  @override
  HeroInfo getHeroInfo() {
    return const HeroInfo(
      greeting: AppStrings.heroGreeting,
      name: AppStrings.name,
      role: AppStrings.role,
      tagline: AppStrings.heroTagline,
      location: AppStrings.location,
    );
  }
}
