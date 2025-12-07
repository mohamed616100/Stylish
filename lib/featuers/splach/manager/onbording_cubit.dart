import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/core/helper/my_navgitor.dart';
import 'package:stylish/featuers/splach/views/get_started_view.dart';
import 'onbording_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final int pagesCount;
  final PageController pageController = PageController();

  OnboardingCubit({required this.pagesCount})
      : super(OnboardingState(currentIndex: 0, isLast: false));

  static OnboardingCubit of(context) =>
      BlocProvider.of(context);

  void onPageChanged(int index) {
    emit(
      state.copyWith(
        currentIndex: index,
        isLast: index == pagesCount - 1,
      ),
    );
  }

  void next(PageController controller,BuildContext context) {
    if (state.currentIndex < pagesCount - 1) {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      MyNavigator.goTo(context,GetStartedView(),
          type:NavigatorType.pushAndRemoveUntil);
    }
  }

  void prev(PageController controller) {
    if (state.currentIndex > 0) {
      controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  void skip() {
    pageController.animateToPage(
      pagesCount - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

}
