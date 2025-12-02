import 'package:equatable/equatable.dart';

class ForecastEntity extends Equatable {
  final DateTime dateTime;
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
  final double? pop; // Probability of precipitation

  const ForecastEntity({
    required this.dateTime,
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
    this.pop,
  });

  @override
  List<Object?> get props => [
        dateTime,
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
        pop,
      ];
}

class ForecastListEntity extends Equatable {
  final String cityName;
  final String country;
  final List<ForecastEntity> forecasts;

  const ForecastListEntity({
    required this.cityName,
    required this.country,
    required this.forecasts,
  });

  @override
  List<Object?> get props => [cityName, country, forecasts];
}
