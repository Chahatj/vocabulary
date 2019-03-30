import 'package:flutter/material.dart';

import 'vocabulary_card.dart';

class CardStack extends StatefulWidget {
  final Function onCardChanged;

  CardStack({this.onCardChanged});
  @override
  _CardStackState createState() => _CardStackState();
}

class _CardStackState extends State<CardStack>
    with SingleTickerProviderStateMixin {
  var cards = [
    VocabularyCard(index: 0, word: 'Practice', meaning: 'regularly, habitual', imageUrl: "image1.jpeg"),
    VocabularyCard(index: 1, word: 'Support', meaning: 'material assistance', imageUrl: "image2.jpeg"),
    VocabularyCard(index: 2, word: 'Idea', meaning: 'thougth or suggestion', imageUrl: "image5.jpeg"),
    VocabularyCard(index: 3, word: 'Office', meaning: 'Place for work', imageUrl: "image3.jpeg"),
    VocabularyCard(index: 4, word: 'Money', meaning: 'wealth, assets', imageUrl: "image4.jpeg"),
  ];
  int currentIndex;
  AnimationController controller;
  CurvedAnimation curvedAnimation;
  Animation<Offset> _translationAnim;
  Animation<Offset> _moveAnim;
  Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );
    curvedAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeOut);

    _translationAnim = Tween(begin: Offset(0.0, 0.0), end: Offset(0.0, -1000.0))
        .animate(controller)
          ..addListener(() {
            setState(() {});
          });

    _scaleAnim = Tween(begin: 0.965, end: 1.0).animate(curvedAnimation);
    _moveAnim = Tween(begin: Offset(0.0, 0.05), end: Offset(0.0, 0.0))
        .animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        overflow: Overflow.visible,
        children: cards.reversed.map((card) {
          if (cards.indexOf(card) <= 2) {
            return GestureDetector(
              onVerticalDragEnd: _verticalDragEnd,
              child: Transform.translate(
                offset: _getFlickTransformOffset(card),
                child: FractionalTranslation(
                  translation: _getStackedCardOffset(card),
                  child: Transform.scale(
                    scale: _getStackedCardScale(card),
                    child: Center(child: card),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        }).toList());
  }

  Offset _getStackedCardOffset(VocabularyCard card) {
    int diff = card.index - currentIndex;
    if (card.index == currentIndex + 1) {
      return _moveAnim.value;
    } else if (diff > 0 && diff <= 2) {
      return Offset(0.0, 0.05 * diff);
    } else {
      return Offset(0.0, 0.0);
    }
  }

  double _getStackedCardScale(VocabularyCard card) {
    int diff = card.index - currentIndex;
    if (card.index == currentIndex) {
      return 1.0;
    } else if (card.index == currentIndex + 1) {
      return _scaleAnim.value;
    } else {
      return (1 - (0.035 * diff.abs()));
    }
  }

  Offset _getFlickTransformOffset(VocabularyCard card) {
    if (card.index == currentIndex) {
      return _translationAnim.value;
    }
    return Offset(0.0, 0.0);
  }

  void _verticalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity < 0) {
      // Swiped Bottom to Top
      controller.forward().whenComplete(() {
        setState(() {
          controller.reset();
          VocabularyCard removedCard = cards.removeAt(0);
          cards.add(removedCard);
          currentIndex = cards[0].index;
          if (widget.onCardChanged != null)
            widget.onCardChanged(cards[0].word, cards[0].meaning, cards[0].imageUrl);
        });
      });
    }
  }
}