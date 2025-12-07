import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleState {
  final Locale locale;
  const LocaleState(this.locale);
}

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit(Locale initialLocale) : super(LocaleState(initialLocale));

  static LocaleCubit of(BuildContext context) =>
      BlocProvider.of<LocaleCubit>(context);

  Future<void> _saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang_code', locale.languageCode);
  }

  Future<void> setArabic() async {
    const locale = Locale('ar');
    emit(const LocaleState(locale));
    await _saveLocale(locale);
  }

  Future<void> setEnglish() async {
    const locale = Locale('en');
    emit(const LocaleState(locale));
    await _saveLocale(locale);
  }

  Future<void> toggleLocale() async {
    if (state.locale.languageCode == 'en') {
      await setArabic();
    } else {
      await setEnglish();
    }
  }
}
