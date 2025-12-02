import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
  Future<WeatherModel> getCurrentWeatherByCoordinates(double lat, double lon);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSourceImpl({required this.dio});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.currentWeather}',
        queryParameters: {
          'q': cityName,
          'appid': ApiConstants.apiKey,
          'units': ApiConstants.units,
        },
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather data');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('City not found');
      } else if (e.response?.statusCode == 401) {
        throw Exception('Invalid API key');
      } else {
        throw Exception('Failed to load weather data: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<WeatherModel> getCurrentWeatherByCoordinates(
      double lat, double lon) async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.currentWeather}',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': ApiConstants.apiKey,
          'units': ApiConstants.units,
        },
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather data');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Invalid API key');
      } else {
        throw Exception('Failed to load weather data: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
