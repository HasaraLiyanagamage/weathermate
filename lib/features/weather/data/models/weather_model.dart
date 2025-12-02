import '../../domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.cityName,
    required super.country,
    required super.latitude,
    required super.longitude,
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
    required super.dateTime,
    required super.visibility,
    super.sunrise,
    super.sunset,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] ?? '',
      country: json['sys']?['country'] ?? '',
      latitude: (json['coord']?['lat'] ?? 0.0).toDouble(),
      longitude: (json['coord']?['lon'] ?? 0.0).toDouble(),
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
      dateTime: DateTime.fromMillisecondsSinceEpoch(
        (json['dt'] ?? 0) * 1000,
      ),
      visibility: json['visibility'] ?? 0,
      sunrise: json['sys']?['sunrise'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000)
          : null,
      sunset: json['sys']?['sunset'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
      'sys': {
        'country': country,
        'sunrise': sunrise?.millisecondsSinceEpoch ?? 0,
        'sunset': sunset?.millisecondsSinceEpoch ?? 0,
      },
      'coord': {
        'lat': latitude,
        'lon': longitude,
      },
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
      'dt': dateTime.millisecondsSinceEpoch ~/ 1000,
      'visibility': visibility,
    };
  }
}
