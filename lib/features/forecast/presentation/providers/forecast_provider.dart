import 'package:flutter/foundation.dart';
import '../../domain/entities/forecast_entity.dart';
import '../../domain/repositories/forecast_repository.dart';

enum ForecastStatus { initial, loading, loaded, error }

class ForecastProvider with ChangeNotifier {
  final ForecastRepository repository;

  ForecastProvider({required this.repository});

  ForecastListEntity? _forecast;
  ForecastStatus _status = ForecastStatus.initial;
  String? _errorMessage;

  ForecastListEntity? get forecast => _forecast;
  ForecastStatus get status => _status;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _status == ForecastStatus.loading;
  bool get hasError => _status == ForecastStatus.error;
  bool get hasData => _status == ForecastStatus.loaded && _forecast != null;

  Future<void> getForecastByCity(String cityName) async {
    _status = ForecastStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _forecast = await repository.getForecast(cityName);
      _status = ForecastStatus.loaded;
      _errorMessage = null;
    } catch (e) {
      _status = ForecastStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _forecast = null;
    }
    notifyListeners();
  }

  Future<void> getForecastByCoordinates(double lat, double lon) async {
    _status = ForecastStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _forecast = await repository.getForecastByCoordinates(lat, lon);
      _status = ForecastStatus.loaded;
      _errorMessage = null;
    } catch (e) {
      _status = ForecastStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _forecast = null;
    }
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    if (_status == ForecastStatus.error) {
      _status = ForecastStatus.initial;
    }
    notifyListeners();
  }
}
