import 'package:flutter/material.dart';
import '../../data/datasources/alerts_local_datasource.dart';
import '../../data/models/weather_alert_model.dart';
import '../../../weather/domain/entities/weather_entity.dart';

class AlertsProvider extends ChangeNotifier {
  final AlertsLocalDatasource _localDatasource;
  
  List<WeatherAlertModel> _alerts = [];
  bool _isLoading = false;
  String? _errorMessage;

  AlertsProvider(this._localDatasource);

  List<WeatherAlertModel> get alerts => _alerts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  Future<void> loadAlerts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _alerts = await _localDatasource.getAlerts();
    } catch (e) {
      _errorMessage = 'Failed to load alerts: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addAlert(WeatherAlertModel alert) async {
    try {
      await _localDatasource.addAlert(alert);
      await loadAlerts();
    } catch (e) {
      _errorMessage = 'Failed to add alert: $e';
      notifyListeners();
    }
  }

  Future<void> updateAlert(WeatherAlertModel alert) async {
    try {
      await _localDatasource.updateAlert(alert);
      await loadAlerts();
    } catch (e) {
      _errorMessage = 'Failed to update alert: $e';
      notifyListeners();
    }
  }

  Future<void> deleteAlert(String alertId) async {
    try {
      await _localDatasource.deleteAlert(alertId);
      await loadAlerts();
    } catch (e) {
      _errorMessage = 'Failed to delete alert: $e';
      notifyListeners();
    }
  }

  Future<void> toggleAlert(String alertId) async {
    try {
      final alert = _alerts.firstWhere((a) => a.id == alertId);
      final updatedAlert = alert.copyWith(isEnabled: !alert.isEnabled);
      await updateAlert(updatedAlert);
    } catch (e) {
      _errorMessage = 'Failed to toggle alert: $e';
      notifyListeners();
    }
  }

  List<String> checkAlerts(WeatherEntity weather) {
    final triggeredAlerts = <String>[];

    for (var alert in _alerts) {
      if (!alert.isEnabled) continue;
      if (alert.cityName.toLowerCase() != weather.cityName.toLowerCase()) continue;

      bool triggered = false;

      switch (alert.alertType) {
        case 'temperature':
          if (alert.condition == 'above' && weather.temperature > alert.threshold) {
            triggered = true;
          } else if (alert.condition == 'below' && weather.temperature < alert.threshold) {
            triggered = true;
          }
          break;
        case 'humidity':
          if (alert.condition == 'above' && weather.humidity > alert.threshold) {
            triggered = true;
          } else if (alert.condition == 'below' && weather.humidity < alert.threshold) {
            triggered = true;
          }
          break;
        case 'wind':
          if (alert.condition == 'above' && weather.windSpeed > alert.threshold) {
            triggered = true;
          } else if (alert.condition == 'below' && weather.windSpeed < alert.threshold) {
            triggered = true;
          }
          break;
        case 'rain':
          if (weather.weatherMain.toLowerCase().contains('rain')) {
            triggered = true;
          }
          break;
        case 'snow':
          if (weather.weatherMain.toLowerCase().contains('snow')) {
            triggered = true;
          }
          break;
      }

      if (triggered) {
        triggeredAlerts.add('${alert.cityName}: ${alert.getAlertDescription()}');
      }
    }

    return triggeredAlerts;
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
