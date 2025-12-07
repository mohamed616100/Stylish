import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvg extends StatelessWidget {
  const CustomSvg({super.key,
    required this.path,
    this.width,
    this.height,
    this.color
  });
  final Color? color;
  final String path;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
        path,
        color:color ,
        width: width,
        height: height
    );
  }
}