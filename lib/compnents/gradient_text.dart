import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    required this.children,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;
  final List<InlineSpan> children;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: RichText(
        text: TextSpan(
          text: text,
          style: style,
          children: children,
        ),
      ),
    );
  }
}
