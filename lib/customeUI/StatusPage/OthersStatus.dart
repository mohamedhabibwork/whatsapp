import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config.dart';

class OthersStatus extends StatelessWidget {
  final String name;
  final String image;
  final String time;
  final bool isSeen;
  final int statusNum;

  const OthersStatus(
      {Key? key,
      required this.name,
      required this.image,
      required this.time,
      this.statusNum = 1,
      this.isSeen = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context).copyWith(
        textTheme: TextTheme(
      caption: Theme.of(context)
          .textTheme
          .caption!
          .apply(color: Colors.grey[900], fontSizeDelta: 0),
      subtitle1: Theme.of(context)
          .textTheme
          .subtitle1!
          .apply(color: Colors.black, fontWeightDelta: 4),
    ));
    return ListTile(
      leading: CustomPaint(
        painter: StatusPointer(
          isSeen: this.isSeen,
          StatusNum: this.statusNum,
        ),
        child: CircleAvatar(
          radius: 26,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(image),
        ),
      ),
      title: Text(
        name,
        style: theme.textTheme.subtitle1,
      ),
      subtitle: Text(
        'today at, $time',
        style: theme.textTheme.caption,
      ),
    );
  }
}

degreeToAngle(double degree) {
  return degree * pi / 180;
}

class StatusPointer extends CustomPainter {
  final bool isSeen;
  final int StatusNum;

  StatusPointer({this.isSeen = false, this.StatusNum = 1});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 6.0
      ..color = isSeen ? Colors.grey : APP_STATUS_COLOR
      ..style = PaintingStyle.stroke;
    drawArc(canvas, size, paint);
  }

  void drawArc(Canvas canvas, Size size, Paint paint) {
    if (StatusNum == 1) {
      canvas.drawArc(
          Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          degreeToAngle(this.StatusNum.toDouble()),
          degreeToAngle(360),
          false,
          paint);
    } else {
      double degree = -90;
      double arc = 360 / StatusNum;

      for (var i = 0; i < StatusNum; ++i) {
        canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height),
            degreeToAngle(degree + 4), degreeToAngle(arc - 8), false, paint);
        degree += arc;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
