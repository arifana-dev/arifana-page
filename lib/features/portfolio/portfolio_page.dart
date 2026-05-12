import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/section_keys.dart';
import '../../core/widgets/nav_bar.dart';
import '../about/data/about_repository.dart';
import '../about/presentation/bloc/about_bloc.dart';
import '../about/presentation/widgets/about_section.dart';
import '../contact/data/contact_repository.dart';
import '../contact/presentation/bloc/contact_bloc.dart';
import '../contact/presentation/widgets/contact_section.dart';
import '../experience/data/experience_repository.dart';
import '../experience/presentation/bloc/experience_bloc.dart';
import '../experience/presentation/widgets/experience_section.dart';
import '../hero/data/hero_repository.dart';
import '../hero/presentation/bloc/hero_bloc.dart';
import '../hero/presentation/widgets/hero_section.dart';
import '../projects/data/projects_repository.dart';
import '../projects/presentation/bloc/projects_bloc.dart';
import '../projects/presentation/widgets/projects_section.dart';
import '../skills/data/skills_repository.dart';
import '../skills/presentation/bloc/skills_bloc.dart';
import '../skills/presentation/widgets/skills_section.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HeroBloc(const HeroRepositoryImpl())
            ..add(const HeroLoadRequested()),
        ),
        BlocProvider(
          create: (_) => AboutBloc(const AboutRepositoryImpl())
            ..add(const AboutLoadRequested()),
        ),
        BlocProvider(
          create: (_) => SkillsBloc(const SkillsRepositoryImpl())
            ..add(const SkillsLoadRequested()),
        ),
        BlocProvider(
          create: (_) => ExperienceBloc(const ExperienceRepositoryImpl())
            ..add(const ExperienceLoadRequested()),
        ),
        BlocProvider(
          create: (_) => ProjectsBloc(ProjectsRepositoryImpl())
            ..add(const ProjectsLoadRequested()),
        ),
        BlocProvider(
          create: (_) => ContactBloc(const ContactRepositoryImpl())
            ..add(const ContactLoadRequested()),
        ),
      ],
      child: const _PortfolioView(),
    );
  }
}

class _PortfolioView extends StatelessWidget {
  const _PortfolioView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  key: SectionKeys.keyOf(PortfolioSection.hero),
                  child: const HeroSection(),
                ),
                SizedBox(
                  key: SectionKeys.keyOf(PortfolioSection.about),
                  child: const AboutSection(),
                ),
                SizedBox(
                  key: SectionKeys.keyOf(PortfolioSection.skills),
                  child: const SkillsSection(),
                ),
                SizedBox(
                  key: SectionKeys.keyOf(PortfolioSection.experience),
                  child: const ExperienceSection(),
                ),
                SizedBox(
                  key: SectionKeys.keyOf(PortfolioSection.projects),
                  child: const ProjectsSection(),
                ),
                SizedBox(
                  key: SectionKeys.keyOf(PortfolioSection.contact),
                  child: const ContactSection(),
                ),
              ],
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(),
          ),
        ],
      ),
    );
  }
}
