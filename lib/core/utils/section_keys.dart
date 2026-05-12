import 'package:flutter/material.dart';

enum PortfolioSection { hero, about, skills, experience, projects, contact }

class SectionKeys {
  SectionKeys._();

  static final Map<PortfolioSection, GlobalKey> keys = {
    PortfolioSection.hero: GlobalKey(debugLabel: 'hero'),
    PortfolioSection.about: GlobalKey(debugLabel: 'about'),
    PortfolioSection.skills: GlobalKey(debugLabel: 'skills'),
    PortfolioSection.experience: GlobalKey(debugLabel: 'experience'),
    PortfolioSection.projects: GlobalKey(debugLabel: 'projects'),
    PortfolioSection.contact: GlobalKey(debugLabel: 'contact'),
  };

  static GlobalKey keyOf(PortfolioSection section) => keys[section]!;

  static Future<void> scrollTo(PortfolioSection section) async {
    final key = keys[section];
    final context = key?.currentContext;
    if (context == null) return;
    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
      alignment: 0.0,
    );
  }
}
