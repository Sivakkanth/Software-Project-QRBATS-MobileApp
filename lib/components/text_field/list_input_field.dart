import 'package:flutter/material.dart';

class ListInputFieldWidget extends StatefulWidget {
  final String hintText;
  final Icon icon;
  final double width;
  final List<String> options;
  final String? initialValue;
  final double height;
  final double borderWidth;
  final void Function(String?)? onChanged;

  const ListInputFieldWidget({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.width,
    required this.options,
    this.initialValue,
    this.height = 55.0,
    this.borderWidth = 1.0,
    this.onChanged,
  }) : super(key: key);

  @override
  _ListInputFieldWidgetState createState() => _ListInputFieldWidgetState();
}

class _ListInputFieldWidgetState extends State<ListInputFieldWidget> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF086494),
            width: 3,
          ),
        ),
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedValue,
        onChanged: (newValue) {
          setState(() {
            _selectedValue = newValue;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(newValue);
          }
        },
        items: widget.options.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(color: Color(0xFF086494)),
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Colors.transparent,
          prefixIcon: Icon(
            widget.icon.icon,
            color: Color(0xFF086494),
          ),
          prefixIconColor: Color(0xFF086494),
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Color(0xFF086494),
          ),
        ),
      ),
    );
  }
}
