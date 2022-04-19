
import 'package:flutter/material.dart';

class CustomUnderlineBarIndicator extends Decoration {
  CustomUnderlineBarIndicator({
    required Color color,
  }) : _painter = LinePainter(color);

  final LinePainter _painter;

  @override
  BoxPainter createBoxPainter([Function()? onChanged]) {
    return _painter;
  }
}

class LinePainter extends BoxPainter {
  final Paint _paint;

  LinePainter(Color color)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Offset circleOffset = offset +
        Offset(
          configuration.size!.width / 2,
          configuration.size!.height,
        );
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromCenter(
          center: circleOffset,
          width: configuration.size!.width,
          height: 6,
        ),
        topLeft: const Radius.circular(10),
        topRight: const Radius.circular(10),
      ),
      _paint,
    );
  }
}
