import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';

class FavoriteCity {
  final String name;
  final String country;
  final double latitude;
  final double longitude;

  FavoriteCity({
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory FavoriteCity.fromJson(Map<String, dynamic> json) {
    return FavoriteCity(
      name: json['name'],
      country: json['country'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

abstract class FavoritesLocalDataSource {
  Future<List<FavoriteCity>> getFavoriteCities();
  Future<void> addFavoriteCity(FavoriteCity city);
  Future<void> removeFavoriteCity(String cityName);
  Future<bool> isFavorite(String cityName);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final SharedPreferences sharedPreferences;

  FavoritesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<FavoriteCity>> getFavoriteCities() async {
    try {
      final String? citiesJson =
          sharedPreferences.getString(AppConstants.favoriteCitiesKey);
      if (citiesJson != null) {
        final List<dynamic> decoded = json.decode(citiesJson);
        return decoded.map((item) => FavoriteCity.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to load favorite cities: $e');
    }
  }

  @override
  Future<void> addFavoriteCity(FavoriteCity city) async {
    try {
      final cities = await getFavoriteCities();
      
      // Check if city already exists
      if (!cities.any((c) => c.name.toLowerCase() == city.name.toLowerCase())) {
        cities.add(city);
        final String encoded =
            json.encode(cities.map((c) => c.toJson()).toList());
        await sharedPreferences.setString(
            AppConstants.favoriteCitiesKey, encoded);
      }
    } catch (e) {
      throw Exception('Failed to add favorite city: $e');
    }
  }

  @override
  Future<void> removeFavoriteCity(String cityName) async {
    try {
      final cities = await getFavoriteCities();
      cities.removeWhere(
          (city) => city.name.toLowerCase() == cityName.toLowerCase());
      final String encoded = json.encode(cities.map((c) => c.toJson()).toList());
      await sharedPreferences.setString(AppConstants.favoriteCitiesKey, encoded);
    } catch (e) {
      throw Exception('Failed to remove favorite city: $e');
    }
  }

  @override
  Future<bool> isFavorite(String cityName) async {
    try {
      final cities = await getFavoriteCities();
      return cities
          .any((city) => city.name.toLowerCase() == cityName.toLowerCase());
    } catch (e) {
      return false;
    }
  }
}
