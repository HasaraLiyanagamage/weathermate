import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../weather/presentation/providers/weather_provider.dart';
import '../../../weather/presentation/widgets/weather_info_card.dart';
import '../../../weather/presentation/widgets/weather_detail_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _recentSearches = [];
  String _selectedRegion = 'All';
  
  final Map<String, List<String>> _citiesByRegion = {
    'All': [
      'London',
      'New York',
      'Tokyo',
      'Paris',
      'Sydney',
      'Dubai',
      'Singapore',
      'Mumbai',
      'Los Angeles',
      'Toronto',
    ],
    'Europe': [
      'London',
      'Paris',
      'Berlin',
      'Rome',
      'Madrid',
      'Amsterdam',
      'Vienna',
      'Prague',
    ],
    'Asia': [
      'Tokyo',
      'Singapore',
      'Mumbai',
      'Bangkok',
      'Seoul',
      'Beijing',
      'Hong Kong',
      'Dubai',
    ],
    'Americas': [
      'New York',
      'Los Angeles',
      'Toronto',
      'Mexico City',
      'São Paulo',
      'Buenos Aires',
      'Miami',
      'Chicago',
    ],
    'Oceania': [
      'Sydney',
      'Melbourne',
      'Auckland',
      'Brisbane',
      'Perth',
      'Wellington',
    ],
    'Africa': [
      'Cairo',
      'Lagos',
      'Johannesburg',
      'Nairobi',
      'Cape Town',
      'Casablanca',
    ],
  };

  List<String> get _popularCities => _citiesByRegion[_selectedRegion] ?? [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchCity(String cityName) {
    if (cityName.trim().isEmpty) return;

    context.read<WeatherProvider>().getWeatherByCity(cityName.trim());

    if (!_recentSearches.contains(cityName)) {
      setState(() {
        _recentSearches.insert(0, cityName);
        if (_recentSearches.length > 10) {
          _recentSearches.removeLast();
        }
      });
    }

    _searchController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search City'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter city name...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) => setState(() {}),
              onSubmitted: _searchCity,
              textInputAction: TextInputAction.search,
            ),
          ),
          Expanded(
            child: Consumer<WeatherProvider>(
              builder: (context, weatherProvider, child) {
                if (weatherProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (weatherProvider.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            weatherProvider.errorMessage ?? 'An error occurred',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            weatherProvider.clearError();
                          },
                          child: const Text('Dismiss'),
                        ),
                      ],
                    ),
                  );
                }

                if (weatherProvider.hasData) {
                  final weather = weatherProvider.weather!;
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WeatherInfoCard(weather: weather),
                        const SizedBox(height: 16),
                        Text(
                          'Details',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 12),
                        WeatherDetailCard(weather: weather),
                      ],
                    ),
                  );
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_recentSearches.isNotEmpty) ...[
                        Text(
                          'Recent Searches',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _recentSearches.map((city) {
                            return ActionChip(
                              label: Text(city),
                              avatar: const Icon(Icons.history, size: 18),
                              onPressed: () => _searchCity(city),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 24),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Popular Cities',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          DropdownButton<String>(
                            value: _selectedRegion,
                            underline: Container(),
                            items: _citiesByRegion.keys.map((region) {
                              return DropdownMenuItem(
                                value: region,
                                child: Text(region),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() => _selectedRegion = value!);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _popularCities.length,
                        itemBuilder: (context, index) {
                          final city = _popularCities[index];
                          return Card(
                            child: ListTile(
                              leading: const Icon(Icons.location_city),
                              title: Text(city),
                              trailing: const Icon(Icons.arrow_forward_ios,
                                  size: 16),
                              onTap: () => _searchCity(city),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
