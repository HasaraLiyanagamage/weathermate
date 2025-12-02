import 'package:flutter/material.dart';
import '../../../../core/utils/weather_utils.dart';
import '../../domain/entities/weather_entity.dart';

class WeatherDetailCard extends StatelessWidget {
  final WeatherEntity weather;

  const WeatherDetailCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDetailRow(
              context,
              Icons.water_drop,
              'Humidity',
              WeatherUtils.formatHumidity(weather.humidity),
              Colors.blue,
            ),
            const Divider(),
            _buildDetailRow(
              context,
              Icons.air,
              'Wind Speed',
              WeatherUtils.formatWindSpeed(weather.windSpeed),
              Colors.teal,
            ),
            const Divider(),
            _buildDetailRow(
              context,
              Icons.navigation,
              'Wind Direction',
              WeatherUtils.getWindDirection(weather.windDeg),
              Colors.green,
            ),
            const Divider(),
            _buildDetailRow(
              context,
              Icons.compress,
              'Pressure',
              WeatherUtils.formatPressure(weather.pressure),
              Colors.orange,
            ),
            const Divider(),
            _buildDetailRow(
              context,
              Icons.cloud,
              'Cloudiness',
              '${weather.clouds}%',
              Colors.grey,
            ),
            const Divider(),
            _buildDetailRow(
              context,
              Icons.visibility,
              'Visibility',
              '${(weather.visibility / 1000).toStringAsFixed(1)} km',
              Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
