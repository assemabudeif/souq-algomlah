part of 'language_cubit.dart';

abstract class LanguageState {}

class LanguageInitial extends LanguageState {}

class LanguageSelectedInitialState extends LanguageState {}

class LanguageSelectedState extends LanguageState {}

class LanguageShopAsGuestState extends LanguageState {}

class LanguageGetCitiesLoadingState extends LanguageState {}

class LanguageGetCitiesSuccessState extends LanguageState {}

class LanguageGetCitiesErrorState extends LanguageState {}
