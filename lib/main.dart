import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylish/featuers/place_order/manager/cart_cubit.dart';
import 'package:stylish/featuers/product/manager/cubit.dart';
import 'core/ theme/app_them.dart';
import 'core/ theme/them_manager/them_cubit.dart';
import 'core/ theme/them_manager/them_state.dart';
import 'core/local/cubit.dart';
import 'core/widgets/image_manager/cubit/image_manager_cubit.dart';
import 'featuers/search/manager/search_cubit.dart';
import 'featuers/splach/views/splach_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final savedCode = prefs.getString('lang_code') ?? 'en';
  final initialLocale = Locale(savedCode);
  final isDark = prefs.getBool('is_dark') ?? false;

  final cartCubit = CartCubit();
  await cartCubit.loadCart();

  runApp(
    StylishRoot(
      initialLocale: initialLocale,
      initialIsDark: isDark,
      cartCubit: cartCubit,
    ),
  );
}

class StylishRoot extends StatelessWidget {
  final Locale initialLocale;
  final bool initialIsDark;
  final CartCubit cartCubit;

  const StylishRoot({
    super.key,
    required this.initialLocale,
    required this.initialIsDark,
    required this.cartCubit,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemCubit(
            isDarkInitial: initialIsDark,
          ),
        ),

        BlocProvider.value(value: cartCubit),

        BlocProvider(create: (_) => AddNumberCubit()),
        BlocProvider(create: (_) => SearchCubit()),
        BlocProvider(create: (_) => ImageManagerCubit()),
        BlocProvider(create: (_) => LocaleCubit(initialLocale)),
      ],
      child: const StylishApp(),
    );
  }
}

class StylishApp extends StatelessWidget {
  const StylishApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemCubit, ThemState>(
      builder: (context, themeState) {
        final themeCubit = ThemCubit.get(context);

        return BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, localeState) {
            return ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                final langCode = localeState.locale.languageCode;

                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode: themeCubit.isDark ? ThemeMode.dark : ThemeMode.light,
                  localizationsDelegates: AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale: localeState.locale,
                  builder: (context, widget) {
                    return Directionality(
                      textDirection:
                      langCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                      child: widget!,
                    );
                  },
                  home: child,
                );
              },
              child: const SplachView(),
            );
          },
        );
      },
    );
  }
}
