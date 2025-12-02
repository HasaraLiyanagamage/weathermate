import 'package:flutter/material.dart';

class AppColors {
  // ========================================
  // GREEN PALETTE - Based on Design System
  // ========================================
  
  // Core Green Palette (Light to Dark)
  static const Color green1 = Color(0xFFD8F3DC); // Lightest mint
  static const Color green2 = Color(0xFFB7E4C7); // Light mint green
  static const Color green3 = Color(0xFF95D5B2); // Medium mint
  static const Color green4 = Color(0xFF74C69D); // Teal green
  static const Color green5 = Color(0xFF52B788); // Medium teal
  static const Color green6 = Color(0xFF40916C); // Deep teal
  static const Color green7 = Color(0xFF2D6A4F); // Forest green
  static const Color green8 = Color(0xFF1B4332); // Dark forest
  static const Color green9 = Color(0xFF081C15); // Darkest green
  
  // Primary Colors (Green Theme)
  static const Color primaryGreen = Color(0xFF52B788); // green5
  static const Color primaryDark = Color(0xFF2D6A4F); // green7
  static const Color primaryLight = Color(0xFF74C69D); // green4
  
  // Accent Colors (Green Variations)
  static const Color accentMint = Color(0xFF95D5B2); // green3
  static const Color accentTeal = Color(0xFF40916C); // green6
  static const Color accentForest = Color(0xFF1B4332); // green8
  
  // Weather Condition Gradients (Green-based)
  static const List<Color> sunnyGradient = [
    Color(0xFFD8F3DC), // green1 - Light & bright
    Color(0xFF95D5B2), // green3
    Color(0xFF52B788), // green5
  ];
  
  static const List<Color> cloudyGradient = [
    Color(0xFFB7E4C7), // green2
    Color(0xFF74C69D), // green4
    Color(0xFF40916C), // green6
  ];
  
  static const List<Color> rainyGradient = [
    Color(0xFF74C69D), // green4
    Color(0xFF40916C), // green6
    Color(0xFF2D6A4F), // green7
  ];
  
  static const List<Color> snowyGradient = [
    Color(0xFFD8F3DC), // green1 - Lightest
    Color(0xFFB7E4C7), // green2
    Color(0xFF95D5B2), // green3
  ];
  
  static const List<Color> stormyGradient = [
    Color(0xFF40916C), // green6
    Color(0xFF2D6A4F), // green7
    Color(0xFF1B4332), // green8
  ];
  
  static const List<Color> nightGradient = [
    Color(0xFF2D6A4F), // green7
    Color(0xFF1B4332), // green8
    Color(0xFF081C15), // green9
  ];
  
  // Background Gradients (Green Theme)
  static const List<Color> defaultGradient = [
    Color(0xFF52B788), // green5
    Color(0xFF40916C), // green6
    Color(0xFF2D6A4F), // green7
  ];
  
  static const List<Color> lightGradient = [
    Color(0xFFD8F3DC), // green1
    Color(0xFFB7E4C7), // green2
    Color(0xFF95D5B2), // green3
  ];
  
  static const List<Color> mediumGradient = [
    Color(0xFF95D5B2), // green3
    Color(0xFF74C69D), // green4
    Color(0xFF52B788), // green5
  ];
  
  static const List<Color> darkGradient = [
    Color(0xFF40916C), // green6
    Color(0xFF2D6A4F), // green7
    Color(0xFF1B4332), // green8
  ];
  
  // Status Colors (Green-based)
  static const Color success = Color(0xFF52B788); // green5
  static const Color warning = Color(0xFF74C69D); // green4
  static const Color error = Color(0xFF40916C); // green6 (darker for contrast)
  static const Color info = Color(0xFF95D5B2); // green3
  
  // Text Colors
  static const Color textPrimary = Color(0xFF081C15); // green9 - Darkest
  static const Color textSecondary = Color(0xFF1B4332); // green8
  static const Color textHint = Color(0xFF74C69D); // green4
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textOnGreen = Color(0xFFD8F3DC); // green1 - Light text on dark green
  
  // Background Colors
  static const Color backgroundLight = Color(0xFFD8F3DC); // green1
  static const Color backgroundDark = Color(0xFF081C15); // green9
  static const Color surfaceLight = Color(0xFFB7E4C7); // green2
  static const Color surfaceDark = Color(0xFF1B4332); // green8
  
  // Card Colors
  static const Color cardLight = Color(0xFFD8F3DC); // green1
  static const Color cardDark = Color(0xFF2D6A4F); // green7
  
  // Get gradient based on weather condition
  static List<Color> getWeatherGradient(String condition, bool isNight) {
    if (isNight) return nightGradient;
    
    switch (condition.toLowerCase()) {
      case 'clear':
      case 'sunny':
        return sunnyGradient;
      case 'clouds':
      case 'cloudy':
        return cloudyGradient;
      case 'rain':
      case 'drizzle':
        return rainyGradient;
      case 'snow':
        return snowyGradient;
      case 'thunderstorm':
        return stormyGradient;
      default:
        return defaultGradient;
    }
  }
  
  // Get color based on temperature (Green scale)
  static Color getTemperatureColor(double temp) {
    if (temp < 0) return green3; // Cold - Light mint
    if (temp < 10) return green4; // Cool - Teal green
    if (temp < 20) return green5; // Mild - Medium teal
    if (temp < 30) return green6; // Warm - Deep teal
    return green7; // Hot - Forest green
  }
  
  // Get AQI color (Green scale)
  static Color getAQIColor(int aqi) {
    if (aqi <= 50) return green5; // Good - Medium teal
    if (aqi <= 100) return green4; // Moderate - Teal green
    if (aqi <= 150) return green6; // Unhealthy for Sensitive - Deep teal
    if (aqi <= 200) return green7; // Unhealthy - Forest green
    if (aqi <= 300) return green8; // Very Unhealthy - Dark forest
    return green9; // Hazardous - Darkest green
  }
  
  // Get gradient for cards (3-color gradient)
  static List<Color> getCardGradient({bool isDark = false}) {
    return isDark ? darkGradient : mediumGradient;
  }
  
  // Get background gradient for pages
  static List<Color> getBackgroundGradient({bool isDark = false}) {
    return isDark ? nightGradient : lightGradient;
  }
}
