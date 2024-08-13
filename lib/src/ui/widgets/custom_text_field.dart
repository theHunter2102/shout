import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/constants.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? svgIconPath;
  final bool obscureText;
  final TextEditingController controller;
  final String obscuringChar;

  CustomTextField({
    this.obscuringChar = '*',
    required this.hintText,
    this.obscureText = false,
    required this.controller,
    this.svgIconPath,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField>
{
  late FocusNode _focusNode;
  bool _isFocus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      _onFocusChange();
    });
  }

  void _onFocusChange()
  {
    setState(() {
      _isFocus = _focusNode.hasFocus;
    });
  }
  double? screenWidth = AppConstants.screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.fromLTRB(20, 0, 20, 0), // Set height
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        obscuringCharacter: widget.obscuringChar,
        focusNode: _focusNode,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF7C82A1),
          ),
          prefixIcon: widget.svgIconPath != null ? Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 20,0),// Thêm padding để căn chỉnh kích thước
            child: SvgPicture.asset(
              widget.svgIconPath!,
              color: _isFocus ? Color.fromARGB(255, 70, 89, 213) : Colors.grey,
              width: 25,
              height: 25,
            ),
          )
              : null,
          // border: OutlineInputBorder(
          // ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 70, 89, 213)
              //   color: Color.fromARGB(64, 225, 225, 225)
            ),

            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          // fillColor: Color.fromARGB(255, 226, 229, 231),
          fillColor: Color.fromARGB(255, 243, 244, 246),
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
        ),
      ),
    );
  }
}
