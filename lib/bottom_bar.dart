import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  //

  final int cardCount;
  final double scrollPercent;

  const BottomBar({
    Key key,
    this.cardCount,
    this.scrollPercent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: double.infinity,
                height: 5.0,
                child: ScrollIndicator(
                  cardCount: cardCount,
                  scrollPercent: scrollPercent,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScrollIndicator extends StatelessWidget {
  //

  final int cardCount;
  final double scrollPercent;

  const ScrollIndicator({
    Key key,
    this.cardCount,
    this.scrollPercent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ScrollIndicatorPainter(
        cardCount: cardCount,
        scrollPercent: scrollPercent,
      ),
      child: Container(),
    );
  }
}

class ScrollIndicatorPainter extends CustomPainter {
  final int cardCount;
  final double scrollPercent;
  final Paint trackPaint;
  final Paint thumbPaint;

  ScrollIndicatorPainter({
    Key key,
    this.cardCount,
    this.scrollPercent,
  })  : trackPaint = Paint()
          ..color = Color(0xFF444444)
          ..style = PaintingStyle.fill,
        thumbPaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    //

    // Draw track
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(
          0.0,
          0.0,
          size.width,
          size.height,
        ),
        topLeft: Radius.circular(5.0),
        topRight: Radius.circular(5.0),
        bottomLeft: Radius.circular(5.0),
        bottomRight: Radius.circular(5.0),
      ),
      trackPaint,
    );

    // Draw thumb
    final double thumbWidth = size.width / cardCount;
    final double thumbLeft = scrollPercent * size.width;

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(
          thumbLeft,
          0.0,
          thumbWidth,
          size.height,
        ),
        topLeft: Radius.circular(5.0),
        topRight: Radius.circular(5.0),
        bottomLeft: Radius.circular(5.0),
        bottomRight: Radius.circular(5.0),
      ),
      thumbPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
