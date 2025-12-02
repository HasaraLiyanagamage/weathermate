class ApiConstants {
  // OpenWeatherMap API Configuration
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = '474f2b4d5d868a30258f63a7eac5243f'; 
  // API Endpoints
  static const String currentWeather = '/weather';
  static const String forecast = '/forecast';
  static const String oneCall = '/onecall';
  
  // Query Parameters
  static const String units = 'metric'; // metric, imperial, standard
  static const String language = 'en';
}
