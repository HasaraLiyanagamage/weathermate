import '../../domain/entities/forecast_entity.dart';
import '../../domain/repositories/forecast_repository.dart';
import '../datasources/forecast_remote_datasource.dart';

class ForecastRepositoryImpl implements ForecastRepository {
  final ForecastRemoteDataSource remoteDataSource;

  ForecastRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ForecastListEntity> getForecast(String cityName) async {
    try {
      final forecastModel = await remoteDataSource.getForecast(cityName);
      return forecastModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ForecastListEntity> getForecastByCoordinates(
      double lat, double lon) async {
    try {
      final forecastModel =
          await remoteDataSource.getForecastByCoordinates(lat, lon);
      return forecastModel;
    } catch (e) {
      rethrow;
    }
  }
}
