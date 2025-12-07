import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylish/core/helper/my_navgitor.dart';
import 'package:stylish/core/utiles/app_colors.dart';
import 'package:stylish/core/utiles/app_icons.dart';
import 'package:stylish/core/utiles/app_images.dart';
import 'package:stylish/core/utiles/app_textstyle.dart';
import 'package:stylish/core/widgets/custom_svg.dart';
import 'package:stylish/featuers/main_layout/views/main_layout_view.dart';
import 'package:stylish/featuers/splach/views/onbording_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SplachView extends StatefulWidget {
  const SplachView({super.key});

  @override
  State<SplachView> createState() => _SplachViewState();
}

class _SplachViewState extends State<SplachView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(
      const AssetImage(AppImages.gesStared),
      context,
    );
  }

  @override
  void initState() {
    super.initState();
    _initAndNavigate();
  }

  Future<void> _initAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');

    if (!mounted) return;

    if (accessToken != null && accessToken.isNotEmpty) {
      MyNavigator.goTo(
        context,
        const MainLayout(),
        type: NavigatorType.pushAndRemoveUntil,
      );
    } else {
      MyNavigator.goTo(
        context,
        const OnbordingView(),
        type: NavigatorType.pushAndRemoveUntil,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomSvg(path: AppIcons.splachIcon),
              SizedBox(width: 5.w),
              Text(
                t.appTitle,
                style: AppTextStyles.headline1.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
