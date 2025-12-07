import 'package:stylish/core/utiles/app_icons.dart';

class OnboardingItem {
  final String imagePath;
  final String titleKey;
  final String descKey;

  OnboardingItem({
    required this.imagePath,
    required this.titleKey,
    required this.descKey});

   static List<OnboardingItem> onboardingItems = [
     OnboardingItem(
         imagePath:AppIcons.onBording1,
         titleKey: 'onboarding_choose_title',
         descKey: 'onboarding_choose_desc'),
     OnboardingItem(
         imagePath:AppIcons.onBording2,
         titleKey: 'onboarding_pay_title',
         descKey: 'onboarding_pay_desc'),
     OnboardingItem(
       imagePath: AppIcons.onBording3,
       titleKey: 'onboarding_order_title',
       descKey: 'onboarding_order_desc',
     ),

   ];
    
}
