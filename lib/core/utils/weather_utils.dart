class WeatherUtils {
  // Convert temperature between units
  static double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }
  
  static double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }
  
  // Get weather icon based on condition code
  static String getWeatherIcon(int code) {
    // OpenWeatherMap condition codes
    if (code >= 200 && code < 300) {
      return '⛈️'; // Thunderstorm
    } else if (code >= 300 && code < 400) {
      return '🌧️'; // Drizzle
    } else if (code >= 500 && code < 600) {
      return '🌧️'; // Rain
    } else if (code >= 600 && code < 700) {
      return '❄️'; // Snow
    } else if (code >= 700 && code < 800) {
      return '🌫️'; // Atmosphere (fog, mist, etc.)
    } else if (code == 800) {
      return '☀️'; // Clear
    } else if (code > 800) {
      return '☁️'; // Clouds
    }
    return '🌡️'; // Default
  }
  
  // Get weather description
  static String getWeatherDescription(String main) {
    switch (main.toLowerCase()) {
      case 'clear':
        return 'Clear sky';
      case 'clouds':
        return 'Cloudy';
      case 'rain':
        return 'Rainy';
      case 'drizzle':
        return 'Light rain';
      case 'thunderstorm':
        return 'Thunderstorm';
      case 'snow':
        return 'Snowy';
      case 'mist':
      case 'fog':
        return 'Foggy';
      default:
        return main;
    }
  }
  
  // Get wind direction from degrees
  static String getWindDirection(double degrees) {
    if (degrees >= 337.5 || degrees < 22.5) return 'N';
    if (degrees >= 22.5 && degrees < 67.5) return 'NE';
    if (degrees >= 67.5 && degrees < 112.5) return 'E';
    if (degrees >= 112.5 && degrees < 157.5) return 'SE';
    if (degrees >= 157.5 && degrees < 202.5) return 'S';
    if (degrees >= 202.5 && degrees < 247.5) return 'SW';
    if (degrees >= 247.5 && degrees < 292.5) return 'W';
    if (degrees >= 292.5 && degrees < 337.5) return 'NW';
    return 'N';
  }
  
  // Get UV index description
  static String getUVIndexDescription(double uvIndex) {
    if (uvIndex < 3) return 'Low';
    if (uvIndex < 6) return 'Moderate';
    if (uvIndex < 8) return 'High';
    if (uvIndex < 11) return 'Very High';
    return 'Extreme';
  }
  
  // Get air quality description
  static String getAirQualityDescription(int aqi) {
    switch (aqi) {
      case 1:
        return 'Good';
      case 2:
        return 'Fair';
      case 3:
        return 'Moderate';
      case 4:
        return 'Poor';
      case 5:
        return 'Very Poor';
      default:
        return 'Unknown';
    }
  }
  
  // Format temperature with unit
  static String formatTemperature(double temp, {bool useFahrenheit = false}) {
    if (useFahrenheit) {
      return '${celsiusToFahrenheit(temp).round()}°F';
    }
    return '${temp.round()}°C';
  }
  
  // Format wind speed
  static String formatWindSpeed(double speed) {
    return '${speed.toStringAsFixed(1)} m/s';
  }
  
  // Format humidity
  static String formatHumidity(int humidity) {
    return '$humidity%';
  }
  
  // Format pressure
  static String formatPressure(int pressure) {
    return '$pressure hPa';
  }
}
