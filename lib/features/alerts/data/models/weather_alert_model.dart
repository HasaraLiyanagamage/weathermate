class WeatherAlertModel {
  final String id;
  final String cityName;
  final String alertType;
  final String condition;
  final double threshold;
  final bool isEnabled;
  final DateTime createdAt;

  WeatherAlertModel({
    required this.id,
    required this.cityName,
    required this.alertType,
    required this.condition,
    required this.threshold,
    required this.isEnabled,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cityName': cityName,
      'alertType': alertType,
      'condition': condition,
      'threshold': threshold,
      'isEnabled': isEnabled,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory WeatherAlertModel.fromJson(Map<String, dynamic> json) {
    return WeatherAlertModel(
      id: json['id'],
      cityName: json['cityName'],
      alertType: json['alertType'],
      condition: json['condition'],
      threshold: json['threshold'].toDouble(),
      isEnabled: json['isEnabled'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  WeatherAlertModel copyWith({
    String? id,
    String? cityName,
    String? alertType,
    String? condition,
    double? threshold,
    bool? isEnabled,
    DateTime? createdAt,
  }) {
    return WeatherAlertModel(
      id: id ?? this.id,
      cityName: cityName ?? this.cityName,
      alertType: alertType ?? this.alertType,
      condition: condition ?? this.condition,
      threshold: threshold ?? this.threshold,
      isEnabled: isEnabled ?? this.isEnabled,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  String getAlertDescription() {
    String conditionText = condition == 'above' ? 'exceeds' : 'falls below';
    switch (alertType) {
      case 'temperature':
        return 'Temperature $conditionText ${threshold.round()}°C';
      case 'humidity':
        return 'Humidity $conditionText ${threshold.round()}%';
      case 'wind':
        return 'Wind speed $conditionText ${threshold.round()} m/s';
      case 'rain':
        return 'Rain detected';
      case 'snow':
        return 'Snow detected';
      default:
        return 'Weather condition alert';
    }
  }
}
