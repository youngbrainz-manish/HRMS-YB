import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonWidget {
  Widget buildSvgImage({required String path, required Color color, double? height, double? width}) {
    return SvgPicture.asset(
      path,
      height: height ?? 22,
      width: width ?? 22,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
