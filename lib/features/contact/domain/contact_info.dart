import 'package:equatable/equatable.dart';

class ContactInfo extends Equatable {
  const ContactInfo({
    required this.email,
    required this.phone,
    required this.githubUrl,
    required this.linkedinUrl,
    required this.portfolioUrl,
  });

  final String email;
  final String phone;
  final String githubUrl;
  final String linkedinUrl;
  final String portfolioUrl;

  @override
  List<Object?> get props =>
      [email, phone, githubUrl, linkedinUrl, portfolioUrl];
}
