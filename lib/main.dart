import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import 'card_stack.dart';

void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Vocabulary'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String imageUrl = "image1.jpeg";
  String word = 'a';
  String meaning = 'aa';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.title),
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
             Container(
              decoration:  BoxDecoration(
                image:  DecorationImage(
                  image: AssetImage("assets/$imageUrl"),
                  fit: BoxFit.cover,
                ),
              ),
              child:  BackdropFilter(
                filter:  ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child:  Container(
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
            ),
             Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CardStack(
                    onCardChanged: (word, meaning, url) {
                      setState(() {
                        word = word;
                        meaning = meaning;
                        imageUrl = url;
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}