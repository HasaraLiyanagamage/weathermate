import 'package:flutter/foundation.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/repositories/weather_repository.dart';

enum WeatherStatus { initial, loading, loaded, error }

class WeatherProvider with ChangeNotifier {
  final WeatherRepository repository;

  WeatherProvider({required this.repository});

  WeatherEntity? _weather;
  WeatherStatus _status = WeatherStatus.initial;
  String? _errorMessage;

  WeatherEntity? get weather => _weather;
  WeatherStatus get status => _status;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _status == WeatherStatus.loading;
  bool get hasError => _status == WeatherStatus.error;
  bool get hasData => _status == WeatherStatus.loaded && _weather != null;

  Future<void> getWeatherByCity(String cityName) async {
    _status = WeatherStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _weather = await repository.getCurrentWeather(cityName);
      _status = WeatherStatus.loaded;
      _errorMessage = null;
    } catch (e) {
      _status = WeatherStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _weather = null;
    }
    notifyListeners();
  }

  Future<void> getWeatherByCoordinates(double lat, double lon) async {
    _status = WeatherStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _weather = await repository.getCurrentWeatherByCoordinates(lat, lon);
      _status = WeatherStatus.loaded;
      _errorMessage = null;
    } catch (e) {
      _status = WeatherStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _weather = null;
    }
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    if (_status == WeatherStatus.error) {
      _status = WeatherStatus.initial;
    }
    notifyListeners();
  }
}
