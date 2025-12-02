import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../alerts/presentation/pages/premium_alerts_page.dart';
import '../../../favorites/data/datasources/favorites_local_datasource.dart';
import '../../../favorites/presentation/providers/favorites_provider.dart';
import '../../../forecast/presentation/pages/premium_forecast_page.dart';
import '../../../favorites/presentation/pages/premium_favorites_page.dart';
import '../../../search/presentation/pages/premium_search_page.dart';
import '../../../settings/presentation/pages/premium_settings_page.dart';
import '../providers/weather_provider.dart';
import '../widgets/premium_weather_card.dart';
import '../widgets/premium_detail_cards.dart';
import '../widgets/premium_hourly_forecast.dart';
import '../../../air_quality/presentation/widgets/premium_air_quality_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isLoadingLocation = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentLocation();
  }

  Future<void> _loadCurrentLocation() async {
    setState(() => _isLoadingLocation = true);

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          _showLocationServiceDialog();
        }
        setState(() => _isLoadingLocation = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            _loadDefaultCity();
          }
          setState(() => _isLoadingLocation = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          _loadDefaultCity();
        }
        setState(() => _isLoadingLocation = false);
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      if (mounted) {
        await context
            .read<WeatherProvider>()
            .getWeatherByCoordinates(position.latitude, position.longitude);
      }
    } catch (e) {
      if (mounted) {
        _loadDefaultCity();
      }
    }

    setState(() => _isLoadingLocation = false);
  }

  void _loadDefaultCity() {
    context.read<WeatherProvider>().getWeatherByCity('London');
  }

  void _showLocationServiceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Services Disabled'),
        content: const Text(
            'Please enable location services to get weather for your current location.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _loadDefaultCity();
            },
            child: const Text('Use Default City'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Geolocator.openLocationSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomePage(),
          PremiumSearchPage(
            onSearchComplete: () {
              setState(() => _selectedIndex = 0);
            },
          ),
          const PremiumForecastPage(),
          const PremiumFavoritesPage(),
          const PremiumAlertsPage(),
          const PremiumSettingsPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'Forecast',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildHomePage() {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        if (_isLoadingLocation || weatherProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (weatherProvider.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  weatherProvider.errorMessage ?? 'An error occurred',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _loadCurrentLocation,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (!weatherProvider.hasData) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cloud_off, size: 64),
                const SizedBox(height: 16),
                const Text('No weather data available'),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _loadCurrentLocation,
                  icon: const Icon(Icons.location_on),
                  label: const Text('Get Current Location'),
                ),
              ],
            ),
          );
        }

        final weather = weatherProvider.weather!;
        final weatherColor = AppTheme.getWeatherColor(weather.weatherMain);

        return RefreshIndicator(
          onRefresh: () async {
            await context
                .read<WeatherProvider>()
                .getWeatherByCoordinates(weather.latitude, weather.longitude);
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                backgroundColor: weatherColor,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    '${weather.cityName}, ${weather.country}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          weatherColor,
                          weatherColor.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ),
                actions: [
                  Consumer<FavoritesProvider>(
                    builder: (context, favProvider, child) {
                      return FutureBuilder<bool>(
                        future: favProvider.isFavorite(weather.cityName),
                        builder: (context, snapshot) {
                          final isFav = snapshot.data ?? false;
                          return IconButton(
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              if (isFav) {
                                await favProvider
                                    .removeFavorite(weather.cityName);
                              } else {
                                await favProvider.addFavorite(
                                  FavoriteCity(
                                    name: weather.cityName,
                                    country: weather.country,
                                    latitude: weather.latitude,
                                    longitude: weather.longitude,
                                  ),
                                );
                              }
                              setState(() {});
                            },
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    onPressed: _loadCurrentLocation,
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PremiumWeatherCard(weather: weather),
                      const SizedBox(height: 8),
                      PremiumHourlyForecast(
                        hourlyData: HourlyForecastData.generateMockData(),
                      ),
                      const SizedBox(height: 8),
                      PremiumAirQualityCard(cityName: weather.cityName),
                      const SizedBox(height: 8),
                      PremiumDetailGrid(
                        humidity: weather.humidity.toDouble(),
                        windSpeed: weather.windSpeed,
                        pressure: weather.pressure,
                        visibility: weather.visibility,
                        clouds: weather.clouds,
                      ),
                      const SizedBox(height: 16),
                      _buildSunriseSunset(weather),
                      const SizedBox(height: 16),
                      _buildLastUpdated(weather.dateTime),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSunriseSunset(weather) {
    if (weather.sunrise == null || weather.sunset == null) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Icon(Icons.wb_sunny, color: Colors.orange, size: 32),
                const SizedBox(height: 8),
                const Text('Sunrise', style: TextStyle(fontSize: 12)),
                Text(
                  DateFormatter.formatTime(weather.sunrise!),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Icon(Icons.nights_stay, color: Colors.indigo, size: 32),
                const SizedBox(height: 8),
                const Text('Sunset', style: TextStyle(fontSize: 12)),
                Text(
                  DateFormatter.formatTime(weather.sunset!),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLastUpdated(DateTime dateTime) {
    return Center(
      child: Text(
        'Last updated: ${DateFormatter.getRelativeTime(dateTime)}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
