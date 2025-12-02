import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_alert_model.dart';

class AlertsLocalDatasource {
  static const String _alertsKey = 'weather_alerts';

  Future<List<WeatherAlertModel>> getAlerts() async {
    final prefs = await SharedPreferences.getInstance();
    final alertsJson = prefs.getString(_alertsKey);
    
    if (alertsJson == null) {
      return [];
    }

    final List<dynamic> decoded = json.decode(alertsJson);
    return decoded.map((json) => WeatherAlertModel.fromJson(json)).toList();
  }

  Future<void> saveAlerts(List<WeatherAlertModel> alerts) async {
    final prefs = await SharedPreferences.getInstance();
    final alertsJson = json.encode(alerts.map((alert) => alert.toJson()).toList());
    await prefs.setString(_alertsKey, alertsJson);
  }

  Future<void> addAlert(WeatherAlertModel alert) async {
    final alerts = await getAlerts();
    alerts.add(alert);
    await saveAlerts(alerts);
  }

  Future<void> updateAlert(WeatherAlertModel alert) async {
    final alerts = await getAlerts();
    final index = alerts.indexWhere((a) => a.id == alert.id);
    if (index != -1) {
      alerts[index] = alert;
      await saveAlerts(alerts);
    }
  }

  Future<void> deleteAlert(String alertId) async {
    final alerts = await getAlerts();
    alerts.removeWhere((alert) => alert.id == alertId);
    await saveAlerts(alerts);
  }

  Future<void> clearAlerts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_alertsKey);
  }
}
