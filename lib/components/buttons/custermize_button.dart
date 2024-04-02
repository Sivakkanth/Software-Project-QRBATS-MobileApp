import 'package:flutter/material.dart';

class ButtonCustom extends StatefulWidget {
  final Function()? onTap;
  final String text;
  final double width;
  final Color color;
  final double fontSize;

  const ButtonCustom({
    Key? key,
    required this.onTap,
    required this.text, required this.width, required this.color, required this.fontSize,
  }) : super(key: key);

  @override
  _ButtonCustomState createState() => _ButtonCustomState();
}

class _ButtonCustomState extends State<ButtonCustom> {
  bool _isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isButtonPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isButtonPressed = false;
        });
        widget.onTap?.call();
      },
      onTapCancel: () {
        setState(() {
          _isButtonPressed = false;
        });
      },
      child: Container(
        width: widget.width,
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: _isButtonPressed ? Colors.white : Color(0xFF086494),
          border: Border.all(
            color: Color(0xFF086494),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: _isButtonPressed ? Color(0xFF086494) : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
