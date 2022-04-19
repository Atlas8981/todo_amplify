
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
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset = offset +
        Offset(
          cfg.size!.width / 2,
          cfg.size!.height,
        );
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromCenter(
          center: circleOffset,
          width: cfg.size!.width,
          height: 6,
        ),
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      _paint,
    );
  }
}
