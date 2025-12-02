import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String cityName;
  final String country;
  final double latitude;
  final double longitude;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final double windDeg;
  final int clouds;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;
  final int weatherId;
  final DateTime dateTime;
  final int visibility;
  final DateTime? sunrise;
  final DateTime? sunset;

  const WeatherEntity({
    required this.cityName,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.windDeg,
    required this.clouds,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.weatherId,
    required this.dateTime,
    required this.visibility,
    this.sunrise,
    this.sunset,
  });

  @override
  List<Object?> get props => [
        cityName,
        country,
        latitude,
        longitude,
        temperature,
        feelsLike,
        tempMin,
        tempMax,
        pressure,
        humidity,
        windSpeed,
        windDeg,
        clouds,
        weatherMain,
        weatherDescription,
        weatherIcon,
        weatherId,
        dateTime,
        visibility,
        sunrise,
        sunset,
      ];
}
