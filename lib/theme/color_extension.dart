// lib/theme/color_extension.dart
import 'package:flutter/material.dart';
import 'package:vistacall/theme/app_theme.dart';

extension AppColors on BuildContext {
  // Primary Colors
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get primaryColorLight => Theme.of(this).primaryColorLight;
  Color get primaryColorDark => Theme.of(this).primaryColorDark;
  
  // Background Colors
  Color get backgroundColor => Theme.of(this).colorScheme.background;
  Color get surfaceColor => Theme.of(this).colorScheme.surface;
  Color get scaffoldBackground => Theme.of(this).scaffoldBackgroundColor;
  
  // Text Colors
  Color get textPrimary => Theme.of(this).textTheme.bodyLarge?.color ?? Colors.black;
  Color get textSecondary => Theme.of(this).textTheme.bodyMedium?.color ?? Colors.grey;
  Color get textTertiary => Colors.grey.shade400;
  
  // Error Colors
  Color get errorColor => Theme.of(this).colorScheme.error;
  Color get errorContainer => AppTheme.errorContainer;
  
  // Success Colors
  Color get successColor => AppTheme.successColor;
  Color get successContainer => AppTheme.successContainer;
  
  // Warning Colors
  Color get warningColor => AppTheme.warningColor;
  Color get warningContainer => AppTheme.warningContainer;
  
  // Border Colors
  Color get borderColor => Theme.of(this).dividerColor;
  
  // Get theme colors safely
  Color getColorFromTheme(Color lightColor, Color darkColor) {
    final isDark = Theme.of(this).brightness == Brightness.dark;
    return isDark ? darkColor : lightColor;
  }
}