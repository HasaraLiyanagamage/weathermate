import 'package:flutter/foundation.dart';
import '../../data/datasources/favorites_local_datasource.dart';

class FavoritesProvider with ChangeNotifier {
  final FavoritesLocalDataSource localDataSource;

  FavoritesProvider({required this.localDataSource});

  List<FavoriteCity> _favoriteCities = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<FavoriteCity> get favoriteCities => _favoriteCities;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadFavorites() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _favoriteCities = await localDataSource.getFavoriteCities();
      _isLoading = false;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> addFavorite(FavoriteCity city) async {
    try {
      await localDataSource.addFavoriteCity(city);
      await loadFavorites();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> removeFavorite(String cityName) async {
    try {
      await localDataSource.removeFavoriteCity(cityName);
      await loadFavorites();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String cityName) async {
    return await localDataSource.isFavorite(cityName);
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
