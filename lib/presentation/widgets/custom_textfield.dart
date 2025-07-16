import 'package:flutter/material.dart';
import 'package:vistacall/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onVisibilityToggle;
  final bool showVisibilityToggle;
  final bool isPasswordVisible;
  final String? Function(String?)? validator;
  final bool isRequired;
  const CustomTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0),
    this.showVisibilityToggle = false,
    this.isPasswordVisible = false,
    this.onVisibilityToggle,
    this.validator,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator ?? (isRequired ? (value){
          if(value == null || value.isEmpty){
            return 'This field is required';
          }
          return null;
        }:null),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: showVisibilityToggle? IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: onVisibilityToggle,
          ) : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          filled: true,
          fillColor: AppConstants.greyBackground,
          errorMaxLines: 2
        ),
      ),
    );
  }
}
