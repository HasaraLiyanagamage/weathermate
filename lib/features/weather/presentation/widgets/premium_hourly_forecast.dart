import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/theme/app_colors.dart';

class PremiumHourlyForecast extends StatelessWidget {
  final List<HourlyForecastData> hourlyData;

  const PremiumHourlyForecast({super.key, required this.hourlyData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Hourly Forecast',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: hourlyData.length,
            itemBuilder: (context, index) {
              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 400 + (index * 50)),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: Opacity(
                      opacity: value,
                      child: child,
                    ),
                  );
                },
                child: _HourlyForecastItem(
                  data: hourlyData[index],
                  isFirst: index == 0,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _HourlyForecastItem extends StatelessWidget {
  final HourlyForecastData data;
  final bool isFirst;

  const _HourlyForecastItem({
    required this.data,
    this.isFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isFirst
              ? [
                  Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
                ]
              : [
                  Colors.grey.withOpacity(0.1),
                  Colors.grey.withOpacity(0.05),
                ],
        ),
        border: Border.all(
          color: isFirst
              ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
              : Colors.grey.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isFirst
                ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Time
                Text(
                  isFirst ? 'Now' : data.time,
                  style: TextStyle(
                    fontSize: isFirst ? 14 : 12,
                    fontWeight: isFirst ? FontWeight.bold : FontWeight.w500,
                    color: isFirst
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[600],
                  ),
                ),
                // Weather Icon
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.8, end: 1.0),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Icon(
                        data.icon,
                        color: data.color,
                        size: 40,
                      ),
                    );
                  },
                ),
                // Temperature
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: data.temp.toDouble()),
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Text(
                      '${value.round()}°',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.getTemperatureColor(value),
                      ),
                    );
                  },
                ),
                // Humidity
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.water_drop,
                      size: 14,
                      color: Colors.blue.withOpacity(0.7),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${data.humidity}%',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HourlyForecastData {
  final String time;
  final int temp;
  final int humidity;
  final IconData icon;
  final Color color;

  HourlyForecastData({
    required this.time,
    required this.temp,
    required this.humidity,
    required this.icon,
    required this.color,
  });

  static List<HourlyForecastData> generateMockData() {
    final now = DateTime.now();
    return List.generate(12, (index) {
      final hour = now.add(Duration(hours: index));
      return HourlyForecastData(
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
