import 'package:card_flip_carousel/bottom_bar.dart';
import 'package:card_flip_carousel/card_flipper.dart';
import 'package:card_flip_carousel/carousel_card.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //

  double scrollPercent = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Top margin for status bar
            // SizedBox(height: MediaQuery.of(context).padding.top),

            // Slider item
            Expanded(
              child: CardFlipper(
                onScroll: (double scrollPercent) {
                  setState(() {
                    this.scrollPercent = scrollPercent;
                  });
                },
              ),
            ),

            // Indicators
            BottomBar(
              cardCount: 5,
              scrollPercent: this.scrollPercent,
            ),

            // Bottom margin for safe area
            //SizedBox(height: MediaQuery.of(context).padding.bottom),

            //
          ],
        ),
      ),
    );
  }
}
