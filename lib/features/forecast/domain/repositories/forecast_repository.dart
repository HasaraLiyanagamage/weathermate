import '../entities/forecast_entity.dart';

abstract class ForecastRepository {
  Future<ForecastListEntity> getForecast(String cityName);
  Future<ForecastListEntity> getForecastByCoordinates(double lat, double lon);
}
