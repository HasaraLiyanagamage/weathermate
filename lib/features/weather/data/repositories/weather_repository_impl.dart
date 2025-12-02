import '../../domain/entities/weather_entity.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_datasource.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  Future<WeatherEntity> getCurrentWeather(String cityName) async {
    try {
      final weatherModel = await remoteDataSource.getCurrentWeather(cityName);
      return weatherModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WeatherEntity> getCurrentWeatherByCoordinates(
      double lat, double lon) async {
    try {
      final weatherModel =
          await remoteDataSource.getCurrentWeatherByCoordinates(lat, lon);
      return weatherModel;
    } catch (e) {
      rethrow;
    }
  }
}
