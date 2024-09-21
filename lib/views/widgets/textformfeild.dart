import 'package:flutter/material.dart';

class Textformfeildcustom extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Color backgroundcolor;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  IconData? prefixIcon;
  IconData? sufixIcon;
  final double? height;
  final double? width;

  Textformfeildcustom({
    required this.label,
    this.prefixIcon,
    this.sufixIcon,
    this.hintText,
    this.keyboardType,
    this.controller,
    this.validator,
    this.height,
    this.width,
    this.backgroundcolor = Colors.white,
    this.obscureText = false,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
       color: backgroundcolor, 
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 235, 233, 233))),
          hintText: hintText,
          labelText: label,
          labelStyle: const TextStyle(color: Color.fromARGB(255, 175, 165, 165)),
          prefixIcon: Icon(prefixIcon),
         
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 192, 42, 219), width: 1.0)),
        ),
        validator: validator,
        obscureText: obscureText,
      ),
    );
  }
}