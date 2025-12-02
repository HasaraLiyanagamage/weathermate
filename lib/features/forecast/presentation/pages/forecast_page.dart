import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/weather_utils.dart';
import '../../../weather/presentation/providers/weather_provider.dart';
import '../providers/forecast_provider.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key});

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  @override
  void initState() {
    super.initState();
    _loadForecast();
  }

  void _loadForecast() {
    final weatherProvider = context.read<WeatherProvider>();
    if (weatherProvider.hasData) {
      final weather = weatherProvider.weather!;
      context.read<ForecastProvider>().getForecastByCoordinates(
            weather.latitude,
            weather.longitude,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('5-Day Forecast'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadForecast,
          ),
        ],
      ),
      body: Consumer<ForecastProvider>(
        builder: (context, forecastProvider, child) {
          if (forecastProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (forecastProvider.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    forecastProvider.errorMessage ?? 'An error occurred',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _loadForecast,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (!forecastProvider.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.cloud_off, size: 64),
                  const SizedBox(height: 16),
                  const Text('No forecast data available'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadForecast,
                    child: const Text('Load Forecast'),
                  ),
                ],
              ),
            );
          }

          final forecast = forecastProvider.forecast!;
          final forecasts = forecast.forecasts;

          // Group forecasts by day
          final Map<String, List<dynamic>> groupedForecasts = {};
          for (var item in forecasts) {
            final dateKey = DateFormatter.formatDate(item.dateTime);
            if (!groupedForecasts.containsKey(dateKey)) {
              groupedForecasts[dateKey] = [];
            }
            groupedForecasts[dateKey]!.add(item);
          }

          return RefreshIndicator(
            onRefresh: () async => _loadForecast(),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  '${forecast.cityName}, ${forecast.country}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                _buildTemperatureChart(forecasts.take(8).toList()),
                const SizedBox(height: 24),
                Text(
                  'Daily Forecast',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                ...groupedForecasts.entries.take(5).map((entry) {
                  return _buildDayForecastCard(entry.key, entry.value);
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTemperatureChart(List<dynamic> forecasts) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Temperature Trend',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}°',
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < forecasts.length) {
                            return Text(
                              DateFormatter.formatTime(
                                  forecasts[value.toInt()].dateTime),
                              style: const TextStyle(fontSize: 10),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: forecasts.asMap().entries.map((entry) {
                        return FlSpot(
                          entry.key.toDouble(),
                          entry.value.temperature,
                        );
                      }).toList(),
                      isCurved: true,
                      color: Theme.of(context).colorScheme.primary,
                      barWidth: 3,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayForecastCard(String date, List<dynamic> dayForecasts) {
    // Get min and max temperatures for the day
    final temps = dayForecasts.map((f) => f.temperature).toList();
    final minTemp = temps.reduce((a, b) => a < b ? a : b);
    final maxTemp = temps.reduce((a, b) => a > b ? a : b);

    // Get the weather ID for the icon
    final weatherId = dayForecasts.first.weatherId;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: Text(
          WeatherUtils.getWeatherIcon(weatherId),
          style: const TextStyle(fontSize: 32),
        ),
        title: Text(
          DateFormatter.formatDayOfWeek(dayForecasts.first.dateTime),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(date),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${maxTemp.round()}°',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${minTemp.round()}°',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: dayForecasts.map((forecast) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Text(
                          DateFormatter.formatTime(forecast.dateTime),
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        WeatherUtils.getWeatherIcon(forecast.weatherId),
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(forecast.weatherDescription),
                      ),
                      Text(
                        '${forecast.temperature.round()}°C',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.water_drop, size: 16, color: Colors.blue),
                      const SizedBox(width: 4),
                      Text('${forecast.humidity}%'),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
