import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/alerts/data/datasources/alerts_local_datasource.dart';
import '../../features/alerts/presentation/providers/alerts_provider.dart';
import '../../features/favorites/data/datasources/favorites_local_datasource.dart';
import '../../features/favorites/presentation/providers/favorites_provider.dart';
import '../../features/forecast/data/datasources/forecast_remote_datasource.dart';
import '../../features/forecast/data/repositories/forecast_repository_impl.dart';
import '../../features/forecast/domain/repositories/forecast_repository.dart';
import '../../features/forecast/presentation/providers/forecast_provider.dart';
import '../../features/weather/data/datasources/weather_remote_datasource.dart';
import '../../features/weather/data/repositories/weather_repository_impl.dart';
import '../../features/weather/domain/repositories/weather_repository.dart';
import '../../features/weather/presentation/providers/weather_provider.dart';

class InjectionContainer {
  static late Dio _dio;
  static late SharedPreferences _sharedPreferences;

  // Data Sources
  static late WeatherRemoteDataSource _weatherRemoteDataSource;
  static late ForecastRemoteDataSource _forecastRemoteDataSource;
  static late FavoritesLocalDataSource _favoritesLocalDataSource;
  static late AlertsLocalDatasource _alertsLocalDatasource;

  // Repositories
  static late WeatherRepository _weatherRepository;
  static late ForecastRepository _forecastRepository;

  // Providers
  static late WeatherProvider weatherProvider;
  static late ForecastProvider forecastProvider;
  static late FavoritesProvider favoritesProvider;
  static late AlertsProvider alertsProvider;

  static Future<void> init() async {
    // Initialize Dio
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    // Initialize SharedPreferences
    _sharedPreferences = await SharedPreferences.getInstance();

    // Initialize Data Sources
    _weatherRemoteDataSource = WeatherRemoteDataSourceImpl(dio: _dio);
    _forecastRemoteDataSource = ForecastRemoteDataSourceImpl(dio: _dio);
    _favoritesLocalDataSource =
        FavoritesLocalDataSourceImpl(sharedPreferences: _sharedPreferences);
    _alertsLocalDatasource = AlertsLocalDatasource();

    // Initialize Repositories
    _weatherRepository =
        WeatherRepositoryImpl(remoteDataSource: _weatherRemoteDataSource);
    _forecastRepository =
        ForecastRepositoryImpl(remoteDataSource: _forecastRemoteDataSource);

    // Initialize Providers
    weatherProvider = WeatherProvider(repository: _weatherRepository);
    forecastProvider = ForecastProvider(repository: _forecastRepository);
    favoritesProvider =
        FavoritesProvider(localDataSource: _favoritesLocalDataSource);
    alertsProvider = AlertsProvider(_alertsLocalDatasource);
  }
}
