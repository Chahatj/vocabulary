import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VocabularyCard extends StatelessWidget {
  final int index;
  final String imageUrl;
  final String word;
  final String meaning;
  VocabularyCard({this.index, this.word, this.meaning, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    TextStyle cardTitleStyle =
        Theme.of(context).textTheme.title.copyWith(fontSize: 24.0);
    TextStyle cardSubtitleStyle = Theme.of(context)
        .textTheme
        .title
        .copyWith(fontSize: 20.0, color: Colors.grey);
    TextStyle cardButtonStyle = Theme.of(context)
        .textTheme
        .title
        .copyWith(fontSize: 16.0, color: Colors.white);

    return Card(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Column(children: [
          Image.asset("assets/$imageUrl"),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              word,
              style: cardTitleStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              meaning,
              style: cardSubtitleStyle,
            ),
          ),
          RaisedButton(
            elevation: 2.0,
            color: Colors.blue,
            child: Text(
              "I KNOW",
              style: cardButtonStyle,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            onPressed: () {
              Fluttertoast.showToast(
                msg: 'Hurray...Great',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                fontSize: 16.0,
              );
            },
          )
        ]),
      ),
    );
  }
}