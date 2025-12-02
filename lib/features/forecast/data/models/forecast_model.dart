import '../../domain/entities/forecast_entity.dart';

class ForecastModel extends ForecastEntity {
  const ForecastModel({
    required super.dateTime,
    required super.temperature,
    required super.feelsLike,
    required super.tempMin,
    required super.tempMax,
    required super.pressure,
    required super.humidity,
    required super.windSpeed,
    required super.windDeg,
    required super.clouds,
    required super.weatherMain,
    required super.weatherDescription,
    required super.weatherIcon,
    required super.weatherId,
    super.pop,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      dateTime: DateTime.fromMillisecondsSinceEpoch((json['dt'] ?? 0) * 1000),
      temperature: (json['main']?['temp'] ?? 0.0).toDouble(),
      feelsLike: (json['main']?['feels_like'] ?? 0.0).toDouble(),
      tempMin: (json['main']?['temp_min'] ?? 0.0).toDouble(),
      tempMax: (json['main']?['temp_max'] ?? 0.0).toDouble(),
      pressure: json['main']?['pressure'] ?? 0,
      humidity: json['main']?['humidity'] ?? 0,
      windSpeed: (json['wind']?['speed'] ?? 0.0).toDouble(),
      windDeg: (json['wind']?['deg'] ?? 0.0).toDouble(),
      clouds: json['clouds']?['all'] ?? 0,
      weatherMain: json['weather']?[0]?['main'] ?? '',
      weatherDescription: json['weather']?[0]?['description'] ?? '',
      weatherIcon: json['weather']?[0]?['icon'] ?? '',
      weatherId: json['weather']?[0]?['id'] ?? 0,
      pop: json['pop'] != null ? (json['pop'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dateTime.millisecondsSinceEpoch ~/ 1000,
      'main': {
        'temp': temperature,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'humidity': humidity,
      },
      'wind': {
        'speed': windSpeed,
        'deg': windDeg,
      },
      'clouds': {
        'all': clouds,
      },
      'weather': [
        {
          'id': weatherId,
          'main': weatherMain,
          'description': weatherDescription,
          'icon': weatherIcon,
        }
      ],
      if (pop != null) 'pop': pop,
    };
  }
}

class ForecastListModel extends ForecastListEntity {
  const ForecastListModel({
    required super.cityName,
    required super.country,
    required super.forecasts,
  });

  factory ForecastListModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> list = json['list'] ?? [];
    final forecasts = list.map((item) => ForecastModel.fromJson(item)).toList();

    return ForecastListModel(
      cityName: json['city']?['name'] ?? '',
      country: json['city']?['country'] ?? '',
      forecasts: forecasts,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': {
        'name': cityName,
        'country': country,
      },
      'list': forecasts.map((f) => (f as ForecastModel).toJson()).toList(),
    };
  }
}
