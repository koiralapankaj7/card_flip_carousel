import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {
  //

  final double parallexPercent;

  const CarouselCard({
    Key key,
    this.parallexPercent = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: FractionalTranslation(
            translation: Offset(this.parallexPercent * 2, 0.0),
            child: OverflowBox(
              child: Image.asset(
                'assets/images/wt1.png',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
