library rolling_bottom_bar;

import 'package:flutter/material.dart';

import 'constants/constants.dart';

class BottomBarPainter extends CustomPainter {
  BottomBarPainter(
      {required this.position,
      required this.color,
      required this.showShadow,
      required this.shadowColor,
        required this.notchShadowColor,
     required this.shadowMarginFromNav ,
        required this.notchShadowMarginFromNav,
      required this.notchColor})
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true,
        _notchPaint = Paint()
          ..color = notchColor
          ..isAntiAlias = true;

  /// position
  final double position;

  /// Color for the bottom bar
  final Color color;

  /// Paint value to custom painter
  final Paint _paint;

  /// Shadow Color

  /// Boolean to show shadow
  final bool showShadow;

  /// Paint Value of notch
  final Paint _notchPaint;

  /// Color for the notch
  final Color notchColor;
  final Color shadowColor;
  final Color notchShadowColor;
  final double shadowMarginFromNav;
  final double notchShadowMarginFromNav;

  @override
  void paint(Canvas canvas, Size size) {
    _drawBar(canvas, size);
    _drawFloatingCircle(canvas);
  }

  @override
  bool shouldRepaint(BottomBarPainter oldDelegate) {
    return position != oldDelegate.position || color != oldDelegate.color;
  }

  /// draw bottom bar
  void _drawBar(Canvas canvas, Size size) {
    const left = kMargin;
    final right = size.width - kMargin;
    const top = kMargin;
    const bottom = 90.0;

    final path = Path()
      ..moveTo(0 + kTopRadius, top)
      ..lineTo(position - kTopRadius, top)
      ..relativeArcToPoint(
        const Offset(kTopRadius, kTopRadius),
        radius: const Radius.circular(10),
      )
      ..relativeArcToPoint(
        const Offset((kCircleRadius + kCircleMargin) * 2, 0.0),
        radius: const Radius.circular(kCircleRadius + kCircleMargin),
        clockwise: false,
      )
      ..relativeArcToPoint(
        const Offset(kTopRadius, -kTopRadius),
        radius: const Radius.circular(kTopRadius),
      )
      ..lineTo(size.width - kTopRadius, top)
      ..relativeArcToPoint(
        const Offset(kTopRadius, kTopRadius),
        radius: const Radius.circular(10),
      )
      ..lineTo(size.width, bottom)
      ..lineTo(0, bottom)
      ..lineTo(0, top + kTopRadius)
      ..relativeArcToPoint(
        const Offset(kTopRadius, -kTopRadius),
        radius: const Radius.circular(10),
      );
    final shadowPath = Path()
      ..moveTo(0 + kTopRadius, top - shadowMarginFromNav)
      ..lineTo(position - kTopRadius, top - shadowMarginFromNav)
      ..relativeArcToPoint(
        const Offset(kTopRadius, kTopRadius),
        radius: const Radius.circular(10),
      )
      ..relativeArcToPoint(
        const Offset((kCircleRadius + kCircleMargin) * 2, 0.0),
        radius: const Radius.circular(kCircleRadius + kCircleMargin),
        clockwise: false,
      )
      ..relativeArcToPoint(
        const Offset(kTopRadius, -kTopRadius),
        radius: const Radius.circular(kTopRadius),
      )
      ..lineTo(size.width - kTopRadius, top - shadowMarginFromNav)
      ..relativeArcToPoint(
        const Offset(kTopRadius, kTopRadius),
        radius: const Radius.circular(10),
      )
      ..lineTo(size.width, bottom)
      ..lineTo(0, bottom)
      ..lineTo(0, top + kTopRadius)
      ..relativeArcToPoint(
        const Offset(kTopRadius, -kTopRadius),
        radius: const Radius.circular(10),
      );
    if (this.showShadow) {
      canvas..drawShadow(shadowPath, shadowColor, 5.0, true);
    }
    canvas.drawPath(path, _paint);
  }

  /// Function used to draw the circular indicator
  void _drawFloatingCircle(Canvas canvas) {
    final path = Path()
      ..addArc(
        Rect.fromCircle(
          center: Offset(
            position + kCircleMargin + kCircleRadius,
            kMargin + kCircleMargin,
          ),
          radius: kCircleRadius,
        ),
        0,
        kPi * 2,
      );
    final shadowPath = Path()
      ..addArc(
        Rect.fromCircle(
          center: Offset(
            position + kCircleMargin + kCircleRadius,
            kMargin + kCircleMargin + notchShadowMarginFromNav,
          ),
          radius: kCircleRadius,
        ),
        0,
        kPi * 2,
      );
    if (this.showShadow) {
      canvas..drawShadow(shadowPath, shadowColor, 5.0, true);
    }
    canvas.drawPath(path, _notchPaint);
  }
}
