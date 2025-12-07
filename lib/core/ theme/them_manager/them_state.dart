import 'package:flutter/material.dart';

abstract class ThemState {
  final bool isDark;
  const ThemState(this.isDark);
}

class ThemInitial extends ThemState {
  const ThemInitial(bool isDark) : super(isDark);
}

class ThemChanged extends ThemState {
  const ThemChanged(bool isDark) : super(isDark);
}
