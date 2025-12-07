import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'them_state.dart';

class ThemCubit extends Cubit<ThemState> {
  ThemCubit({required bool isDarkInitial})
      : _isDark = isDarkInitial,
        super(ThemInitial(isDarkInitial));

  static ThemCubit get(context) => BlocProvider.of<ThemCubit>(context);

  bool _isDark;
  bool get isDark => _isDark;

  static const _themeKey = 'is_dark';


  Future<void> _saveTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, value);
  }


  Future<void> toggleTheme() async {
    _isDark = !_isDark;
    emit(ThemChanged(_isDark));
    await _saveTheme(_isDark);
  }
}
