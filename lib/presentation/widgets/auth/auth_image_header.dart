
import 'package:flutter/material.dart';

class AuthImageHeader extends StatelessWidget {
  final bool isSignUpMode;

  const AuthImageHeader({
    super.key,
    required this.isSignUpMode,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      isSignUpMode 
          ? 'assets/images/signup_image.png' 
          : 'assets/images/signin_image.png',
      height: 200,
      width: double.infinity,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return _buildPlaceholder();
      },
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey.shade200,
      child: Center(
        child: Text(
          'Image Not Found\n(${isSignUpMode ? 'signup_image.png' : 'signin_image.png'})',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.shade600),
        ),
      ),
    );
  }
}