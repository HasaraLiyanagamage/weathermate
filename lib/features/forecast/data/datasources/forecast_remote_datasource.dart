import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/forecast_model.dart';

abstract class ForecastRemoteDataSource {
  Future<ForecastListModel> getForecast(String cityName);
  Future<ForecastListModel> getForecastByCoordinates(double lat, double lon);
}

class ForecastRemoteDataSourceImpl implements ForecastRemoteDataSource {
  final Dio dio;

  ForecastRemoteDataSourceImpl({required this.dio});

  @override
  Future<ForecastListModel> getForecast(String cityName) async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.forecast}',
        queryParameters: {
          'q': cityName,
          'appid': ApiConstants.apiKey,
          'units': ApiConstants.units,
        },
      );

      if (response.statusCode == 200) {
        return ForecastListModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load forecast data');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('City not found');
      } else if (e.response?.statusCode == 401) {
        throw Exception('Invalid API key');
      } else {
        throw Exception('Failed to load forecast data: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<ForecastListModel> getForecastByCoordinates(
      double lat, double lon) async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.forecast}',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': ApiConstants.apiKey,
          'units': ApiConstants.units,
        },
      );

      if (response.statusCode == 200) {
        return ForecastListModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load forecast data');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Invalid API key');
      } else {
        throw Exception('Failed to load forecast data: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
