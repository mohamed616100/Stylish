class OnboardingState {
  final int currentIndex;
  final bool isLast;

  const OnboardingState({
    required this.currentIndex,
    required this.isLast,
  });

  OnboardingState copyWith({
    int? currentIndex,
    bool? isLast,
  }) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      isLast: isLast ?? this.isLast,
    );
  }
}
