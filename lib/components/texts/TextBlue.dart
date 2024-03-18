import 'package:flutter/material.dart';

class TextBlue extends StatefulWidget {

  final String text;
  final double fontSize;
  const TextBlue({super.key, required this.text, required this.fontSize});

  @override
  State<TextBlue> createState() => _TextBlueState();
}

class _TextBlueState extends State<TextBlue> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text,style: TextStyle(fontSize: widget.fontSize, fontWeight: FontWeight.bold, color: Color(0xFF086494)));
  }
}
