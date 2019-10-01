import 'dart:ui';

import 'package:card_flip_carousel/carousel_card.dart';
import 'package:flutter/material.dart';

class CardFlipper extends StatefulWidget {
  //

  final Function(double scrollPercent) onScroll;

  const CardFlipper({
    Key key,
    this.onScroll,
  }) : super(key: key);

  @override
  _CardFlipperState createState() => _CardFlipperState();
}

class _CardFlipperState extends State<CardFlipper> with TickerProviderStateMixin {
  //

  double scrollPercent = 0.0;
  // Offset from where user start dragging
  Offset startDrag;
  // Percent of scroll when the user start dragging
  double startDragScrollPercent;
  double finishScrollStart;
  double finishScrollEnd;
  AnimationController finishScrollControler;

  void _onHorizontalDragStart(DragStartDetails details) {
    this.startDrag = details.globalPosition;
    this.startDragScrollPercent = this.scrollPercent;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final Offset currentDrag = details.globalPosition;
    final double dragDistance = this.startDrag.dx - currentDrag.dx;
    // Single card drag percent is total drag distance divided by width of the screen.
    final double singleCardDragPercent = dragDistance / context.size.width;

    final totalCards = 5;
    setState(() {
      this.scrollPercent = (this.startDragScrollPercent + (singleCardDragPercent / totalCards))
          .clamp(0.0, 1.0 - (1 / totalCards));

      if (widget.onScroll != null) {
        widget.onScroll(this.scrollPercent);
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    //
    final totalCards = 5;

    // We will start animation from where user stop dragging i.e, scrollPercent.
    this.finishScrollStart = this.scrollPercent;

    // We have to figure it out where we want to animate to. That means where is the nearest card to snap to.
    // this.scrollPercent * totalCards => if scroll percent is 0.5 then we will get 2.5 if there are five cards. by rounding it we will get 2 which will be divide by totalCards to get our finishScrollEnd.
    this.finishScrollEnd = (this.scrollPercent * totalCards).round() / totalCards;

    // Run animation
    this.finishScrollControler.forward(from: 0.0);

    setState(() {
      this.startDrag = null;
      this.startDragScrollPercent = null;
    });
  }

  @override
  void initState() {
    //

    finishScrollControler = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    )..addListener(() {
        setState(() {
          this.scrollPercent = lerpDouble(
            this.finishScrollStart,
            this.finishScrollEnd,
            this.finishScrollControler.value,
          );

          if (widget.onScroll != null) {
            widget.onScroll(this.scrollPercent);
          }
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    finishScrollControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onHorizontalDragStart,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      // By default if we tap in transperant area gesture detector will not detect tap so we need to sent behavior:HitTestBehavior.translucent so that tap will be detect even in transparent area.
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: _buildAllCards(),
      ),
    );
  }

  // Build single card
  Widget _buildSingleCard({
    @required int index,
    @required int cardCount,
    @required double scrollPercent,
  }) {
    // scrollPercent represent total scroll of the all availavle cards i.e, 5 cards in this case.  So to get single card scroll percent we need to divide by (1 / cardCount). This method is used to spread cards side by side in stack.
    final double cardScrollPercent = scrollPercent / (1 / cardCount);

    final double parallex = scrollPercent - (index / cardCount);

    return FractionalTranslation(
      // For card in index 0 => X offset will be 0
      // For card in index 1 => X offset will be 1
      // For card in index 2 => X offset will be 2
      // For card in index 3 => X offset will be 3
      // For card in index 4 => X offset will be 4
      // Offset 1 in X-axis means complete width of the screen, 2 means double of width of the screen. In this way our all cards will be placed after each cards.
      translation: Offset(index - cardScrollPercent, 0.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CarouselCard(
          parallexPercent: parallex,
        ),
      ),
    );
  }

  // Build all cards for carousel
  List<Widget> _buildAllCards() {
    return <Widget>[
      _buildSingleCard(
        index: 0,
        cardCount: 5,
        scrollPercent: this.scrollPercent,
      ),
      _buildSingleCard(
        index: 1,
        cardCount: 5,
        scrollPercent: this.scrollPercent,
      ),
      _buildSingleCard(
        index: 2,
        cardCount: 5,
        scrollPercent: this.scrollPercent,
      ),
      _buildSingleCard(
        index: 3,
        cardCount: 5,
        scrollPercent: this.scrollPercent,
      ),
      _buildSingleCard(
        index: 4,
        cardCount: 5,
        scrollPercent: this.scrollPercent,
      ),
    ];
  }

  //
  //
}
