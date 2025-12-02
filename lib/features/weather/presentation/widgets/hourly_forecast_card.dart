import 'package:flutter/material.dart';
import '../../../../core/utils/date_formatter.dart';

class HourlyForecastCard extends StatelessWidget {
  final List<HourlyData> hourlyData;

  const HourlyForecastCard({super.key, required this.hourlyData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Hourly Forecast',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hourlyData.length,
                itemBuilder: (context, index) {
                  final data = hourlyData[index];
                  return _HourlyItem(data: data);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HourlyItem extends StatelessWidget {
  final HourlyData data;

  const _HourlyItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            Theme.of(context).colorScheme.primary.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            data.time,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(
            data.icon,
            color: data.color,
            size: 32,
          ),
          Text(
            '${data.temp}°',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.water_drop,
                size: 12,
                color: Colors.blue,
              ),
              const SizedBox(width: 2),
              Text(
                '${data.humidity}%',
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HourlyData {
  final String time;
  final int temp;
  final int humidity;
  final IconData icon;
  final Color color;

  HourlyData({
    required this.time,
    required this.temp,
    required this.humidity,
    required this.icon,
    required this.color,
  });

  static List<HourlyData> generateMockData() {
    final now = DateTime.now();
    return List.generate(12, (index) {
      final hour = now.add(Duration(hours: index));
      return HourlyData(
        time: DateFormatter.formatTime(hour),
        temp: 20 + (index % 8),
        humidity: 60 + (index % 20),
        icon: _getIcon(index),
        color: _getColor(index),
      );
    });
  }

  static IconData _getIcon(int index) {
    final icons = [
      Icons.wb_sunny,
      Icons.wb_sunny,
      Icons.cloud,
      Icons.cloud,
      Icons.wb_cloudy,
      Icons.umbrella,
    ];
    return icons[index % icons.length];
  }

  static Color _getColor(int index) {
    final colors = [
      const Color(0xFFFFB300),
      const Color(0xFFFFB300),
      const Color(0xFF90A4AE),
      const Color(0xFF90A4AE),
      const Color(0xFF78909C),
      const Color(0xFF42A5F5),
    ];
    return colors[index % colors.length];
  }
}
