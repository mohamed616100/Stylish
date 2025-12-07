import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/widgets/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stylish/featuers/settings/views/widgets/lanaguage_toggel.dart';
import 'package:stylish/featuers/settings/views/widgets/them_toggel.dart';
class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
          appBar: CustomAppBar(title: t.settings),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 23.w),
        child: Column(
          children: [
            SizedBox(height: 30.h),
            LanguageToggle(),
            SizedBox(height: 30.h),
            ThemeToggle(),


          ],
        ),
      )
    );
  }
}
