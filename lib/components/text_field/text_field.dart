import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Icon icon;
  final double width;
  final double height;
  final double borderWidth; // Added border thickness property

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.icon,
    required this.width, // Set default width to infinity
    this.height = 55.0, // Set default height to 65.0
    this.borderWidth = 1.0, // Set default border thickness to 1.0
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _obscureText = false; // Default to false, not obscuring

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), // Add border corner radius
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF086494), // Set bottom border color
            width: 3, // Set bottom border thickness
          ),
        ),
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText && _obscureText,
        style: TextStyle(
          color: Color(0xFF086494), // Changed text color
        ),
        decoration: InputDecoration(
          border: InputBorder.none, // Remove default border
          fillColor: Colors.transparent,
          prefixIcon: Icon(
            widget.icon.icon,
            color: Color(0xFF086494), // Changed prefix icon color
          ),
          prefixIconColor: Color(0xFF086494), // Changed prefix icon color
          suffixIcon: widget.obscureText
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Color(0xFF086494), // Changed suffix icon color
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : null,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Color(0xFF086494), // Changed hint text color
          ),
        ),
      ),
    );
  }
}
