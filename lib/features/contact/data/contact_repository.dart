import '../../../core/constants/app_strings.dart';
import '../domain/contact_info.dart';

abstract class ContactRepository {
  ContactInfo getContactInfo();
}

class ContactRepositoryImpl implements ContactRepository {
  const ContactRepositoryImpl();

  @override
  ContactInfo getContactInfo() {
    return const ContactInfo(
      email: AppStrings.email,
      phone: AppStrings.phone,
      githubUrl: AppStrings.githubUrl,
      linkedinUrl: AppStrings.linkedinUrl,
      portfolioUrl: AppStrings.portfolioUrl,
    );
  }
}
