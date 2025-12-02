import 'package:flutter/material.dart';

class AnimatedWeatherIcon extends StatefulWidget {
  final String weatherMain;
  final double size;

  const AnimatedWeatherIcon({
    super.key,
    required this.weatherMain,
    this.size = 100,
  });

  @override
  State<AnimatedWeatherIcon> createState() => _AnimatedWeatherIconState();
}

class _AnimatedWeatherIconState extends State<AnimatedWeatherIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Icon(
        _getWeatherIcon(),
        size: widget.size,
        color: _getWeatherColor(),
      ),
    );
  }

  IconData _getWeatherIcon() {
    switch (widget.weatherMain.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.cloud;
      case 'rain':
      case 'drizzle':
        return Icons.umbrella;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      case 'mist':
      case 'fog':
        return Icons.cloud_queue;
      default:
        return Icons.wb_cloudy;
    }
  }

  Color _getWeatherColor() {
    switch (widget.weatherMain.toLowerCase()) {
      case 'clear':
        return const Color(0xFFFFB300);
      case 'clouds':
        return const Color(0xFF90A4AE);
      case 'rain':
      case 'drizzle':
        return const Color(0xFF42A5F5);
      case 'thunderstorm':
        return const Color(0xFF5E35B1);
      case 'snow':
        return const Color(0xFF81D4FA);
      default:
        return const Color(0xFF78909C);
    }
  }
}
