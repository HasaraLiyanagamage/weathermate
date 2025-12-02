import 'package:flutter/material.dart';

class AirQualityModel {
  final int aqi;
  final String quality;
  final Color color;
  final String description;
  final Map<String, double> components;

  AirQualityModel({
    required this.aqi,
    required this.quality,
    required this.color,
    required this.description,
    required this.components,
  });

  factory AirQualityModel.fromAqi(int aqi) {
    String quality;
    Color color;
    String description;

    if (aqi <= 50) {
      quality = 'Good';
      color = const Color(0xFF4CAF50);
      description = 'Air quality is satisfactory';
    } else if (aqi <= 100) {
      quality = 'Moderate';
      color = const Color(0xFFFFEB3B);
      description = 'Air quality is acceptable';
    } else if (aqi <= 150) {
      quality = 'Unhealthy for Sensitive';
      color = const Color(0xFFFF9800);
      description = 'Sensitive groups may experience health effects';
    } else if (aqi <= 200) {
      quality = 'Unhealthy';
      color = const Color(0xFFF44336);
      description = 'Everyone may begin to experience health effects';
    } else if (aqi <= 300) {
      quality = 'Very Unhealthy';
      color = const Color(0xFF9C27B0);
      description = 'Health alert: everyone may experience serious effects';
    } else {
      quality = 'Hazardous';
      color = const Color(0xFF880E4F);
      description = 'Health warnings of emergency conditions';
    }

    return AirQualityModel(
      aqi: aqi,
      quality: quality,
      color: color,
      description: description,
      components: {},
    );
  }

  factory AirQualityModel.mock(String cityName) {
    // Mock data based on city (for demonstration)
    final random = cityName.hashCode % 200;
    return AirQualityModel.fromAqi(random);
  }
}
