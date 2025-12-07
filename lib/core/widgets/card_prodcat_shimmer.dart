// lib/core/widgets/card_prodcat_shimmer.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A lightweight custom shimmer placeholder for product cards.
/// Designed to be used inside GridView/SliverGrid with no outer padding
/// (put padding on the Grid parent to avoid duplicated spacing).
class CardProdcatShimmerCustom extends StatefulWidget {
  const CardProdcatShimmerCustom({super.key});

  @override
  State<CardProdcatShimmerCustom> createState() => _CardProdcatShimmerCustomState();
}

class _CardProdcatShimmerCustomState extends State<CardProdcatShimmerCustom>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))
      ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey.shade300;
    final highlightColor = Colors.grey.shade100;

    // RepaintBoundary to reduce repaints of sibling widgets
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) {
          final slide = (_ctrl.value * 3) - 1; // moves from -1 to 2
          return _Shimmer(
            baseColor: baseColor,
            highlightColor: highlightColor,
            slidePercent: slide,
            child: child!,
          );
        },
        child: Container(
          // Visual style like a card
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // fallback if parent doesn't give finite height
                final maxH = (constraints.maxHeight.isFinite && constraints.maxHeight > 0)
                    ? constraints.maxHeight
                    : 220.h;

                // image takes ~68% of the card height, rest for small placeholders
                final imageH = maxH * 0.68;
                final bottomH = maxH - imageH;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top: image placeholder
                    Container(
                      height: imageH,
                      width: double.infinity,
                      color: baseColor,
                    ),

                    // Bottom: flexible row of pills and circles
                    SizedBox(
                      height: bottomH,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Row(
                            children: [
                              // Left pill — flexible so it never overflows
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: 10.h,
                                  decoration: BoxDecoration(
                                    color: baseColor,
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                ),
                              ),

                              SizedBox(width: 6.w),

                              // small circle fixed size (safe because small)
                              Container(
                                height: 10.h,
                                width: 10.h,
                                decoration: BoxDecoration(
                                  color: baseColor,
                                  shape: BoxShape.circle,
                                ),
                              ),

                              SizedBox(width: 6.w),

                              // Middle pill — flexible
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: 10.h,
                                  decoration: BoxDecoration(
                                    color: baseColor,
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                ),
                              ),

                              SizedBox(width: 6.w),

                              // small circle fixed
                              Container(
                                height: 10.h,
                                width: 10.h,
                                decoration: BoxDecoration(
                                  color: baseColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _Shimmer extends StatelessWidget {
  const _Shimmer({
    required this.child,
    required this.baseColor,
    required this.highlightColor,
    required this.slidePercent,
  });

  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final double slidePercent;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        final width = rect.width;
        final gradientWidth = width * 0.5;
        final dx = slidePercent * width;

        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            baseColor,
            highlightColor,
            baseColor,
          ],
          stops: [
            ((dx - gradientWidth) / width).clamp(0.0, 1.0),
            (dx / width).clamp(0.0, 1.0),
            ((dx + gradientWidth) / width).clamp(0.0, 1.0),
          ],
        ).createShader(rect);
      },
      blendMode: BlendMode.srcATop,
      child: child,
    );
  }
}
