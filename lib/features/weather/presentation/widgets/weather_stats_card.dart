import 'package:flutter/material.dart';

class WeatherStatsCard extends StatefulWidget {
  final double temperature;
  final int humidity;
  final double windSpeed;
  final int pressure;

  const WeatherStatsCard({
    super.key,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
  });

  @override
  State<WeatherStatsCard> createState() => _WeatherStatsCardState();
}

class _WeatherStatsCardState extends State<WeatherStatsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.insights,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Weather Insights',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildStatRow(
              'Temperature',
              widget.temperature,
              50,
              Icons.thermostat,
              Colors.orange,
            ),
            const SizedBox(height: 16),
            _buildStatRow(
              'Humidity',
              widget.humidity.toDouble(),
              100,
              Icons.water_drop,
              Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildStatRow(
              'Wind Speed',
              widget.windSpeed,
              30,
              Icons.air,
              Colors.teal,
            ),
            const SizedBox(height: 16),
            _buildStatRow(
              'Pressure',
              widget.pressure.toDouble(),
              1100,
              Icons.compress,
              Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(
    String label,
    double value,
    double maxValue,
    IconData icon,
    Color color,
  ) {
    final percentage = (value / maxValue).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: color),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Text(
              value.toStringAsFixed(label == 'Pressure' ? 0 : 1),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: percentage * _controller.value,
                minHeight: 8,
                backgroundColor: color.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            );
          },
        ),
      ],
    );
  }
}
