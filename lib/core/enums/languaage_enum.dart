enum LanguageEnum {
  english,
  arabic,
}

extension LanguageExtension on LanguageEnum {
  String get value {
    switch (this) {
      case LanguageEnum.english:
        return 'en';
      case LanguageEnum.arabic:
        return 'ar';
      default:
        return 'en';
    }
  }
}
