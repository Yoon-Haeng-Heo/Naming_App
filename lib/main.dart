import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'src/random_list.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final randomWord = WordPair.random();
    return MaterialApp(
      home: RandomList(),
    );
  }
}