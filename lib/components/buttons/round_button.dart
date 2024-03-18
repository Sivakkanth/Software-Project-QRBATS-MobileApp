import 'package:flutter/material.dart';

class RoundButton extends StatefulWidget {
  final Function()? onTap;
  final IconData icon;

  const RoundButton({Key? key, required this.onTap, required this.icon}) : super(key: key);

  @override
  _RoundButtonState createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
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
        width: 50, // Adjust the width according to your needs
        height: 50, // Adjust the height according to your needs
        decoration: BoxDecoration(
          color: _isButtonPressed ? Colors.white : Color(0xFF086494),
          shape: BoxShape.circle,
          border: Border.all(
            color: Color(0xFF086494),
          ),
        ),
        child: Icon(
          widget.icon,
          color: _isButtonPressed ? Color(0xFF0077C0) : Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
