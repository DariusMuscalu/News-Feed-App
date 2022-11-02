import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// Renders a svg image.
// On svg it's enough to defined the width, since the height is locked to the aspect ratio.
// ignore: must_be_immutable
class Svg extends StatelessWidget {
  final String iconUrl;
  final double? width;
  final double? height;
  final Color? color;
  final String? semanticLabel;

  const Svg({
    required this.iconUrl,
    this.width,
    this.height,
    this.color,
    this.semanticLabel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
        iconUrl,
        width: width,
        height: height,
        color: color ?? Colors.red,
        semanticsLabel: semanticLabel,
      );
}
