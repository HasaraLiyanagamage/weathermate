# WeatherMate - Flutter Weather Application

A comprehensive weather application built with Flutter following Clean Architecture principles and using the OpenWeatherMap API.

## Features

✅ **5+ Core Features:**
1. **Current Weather by Location** - Get real-time weather for your current GPS location
2. **City Search** - Search weather for any city worldwide
3. **5-Day Forecast** - View detailed weather forecasts with temperature charts
4. **Favorite Cities** - Save and manage your favorite locations
5. **Settings** - Customize temperature units and app preferences

## Architecture

This project follows **Clean Architecture** with a feature-based folder structure:

```
lib/
├── core/
│   ├── constants/      # API and app constants
│   ├── theme/          # App theme configuration
│   ├── utils/          # Utility functions
│   └── di/             # Dependency injection
├── features/
│   ├── weather/
│   │   ├── data/       # Models, data sources, repositories
│   │   ├── domain/     # Entities, repository interfaces
│   │   └── presentation/ # UI, providers, widgets
│   ├── forecast/
│   ├── favorites/
│   ├── search/
│   └── settings/
```

## Technologies Used

- **State Management:** Provider
- **HTTP Client:** Dio
- **Local Storage:** SharedPreferences
- **Location Services:** Geolocator & Geocoding
- **Charts:** FL Chart
- **UI Components:** Material Design 3
- **Architecture Pattern:** Clean Architecture with MVVM

## Setup Instructions

### 1. Prerequisites
- Flutter SDK (3.9.2 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- OpenWeatherMap API Key

### 2. Get OpenWeatherMap API Key
1. Visit [OpenWeatherMap](https://openweathermap.org/api)
2. Sign up for a free account
3. Generate an API key from your account dashboard

### 3. Configure API Key
Open `lib/core/constants/api_constants.dart` and replace `YOUR_API_KEY_HERE` with your actual API key:

```dart
static const String apiKey = 'your_actual_api_key_here';
```

### 4. Install Dependencies
```bash
flutter pub get
```

### 5. Run the Application

**For Android:**
```bash
flutter run
```

**For iOS:**
```bash
cd ios
pod install
cd ..
flutter run
```

**For Web:**
```bash
flutter run -d chrome
```

### 6. Build Release APK
```bash
flutter build apk --release
```

The APK will be generated at: `build/app/outputs/flutter-apk/app-release.apk`

## Permissions

### Android
The app requires the following permissions (already configured in AndroidManifest.xml):
- `ACCESS_FINE_LOCATION` - For GPS location
- `ACCESS_COARSE_LOCATION` - For network-based location
- `INTERNET` - For API calls

### iOS
Location permissions are configured in Info.plist:
- `NSLocationWhenInUseUsageDescription`
- `NSLocationAlwaysUsageDescription`

## Project Structure Details

### Data Layer
- **Models:** Data transfer objects with JSON serialization
- **Data Sources:** Remote (API) and Local (SharedPreferences) data sources
- **Repositories:** Implementation of domain repository interfaces

### Domain Layer
- **Entities:** Business objects
- **Repositories:** Abstract interfaces
- **Use Cases:** Business logic (can be added for more complex operations)

### Presentation Layer
- **Providers:** State management with ChangeNotifier
- **Pages:** Screen widgets
- **Widgets:** Reusable UI components

## Key Features Implementation

### 1. Location-Based Weather
- Uses Geolocator to get current GPS coordinates
- Handles location permissions gracefully
- Falls back to default city if location unavailable

### 2. City Search
- Search any city worldwide
- Recent searches history
- Popular cities quick access

### 3. 5-Day Forecast
- Detailed hourly forecasts
- Temperature trend chart using FL Chart
- Expandable daily forecast cards

### 4. Favorites Management
- Add/remove cities from favorites
- Quick access to favorite locations
- Persistent storage using SharedPreferences

### 5. Settings
- Temperature unit preference (Celsius/Fahrenheit)
- Theme mode (Light/Dark)
- App information

## API Integration

The app uses OpenWeatherMap API with the following endpoints:
- `/weather` - Current weather data
- `/forecast` - 5-day forecast with 3-hour intervals

## Error Handling

- Network errors with user-friendly messages
- Location permission handling
- API key validation
- City not found errors

## UI/UX Features

- Material Design 3
- Responsive layouts
- Pull-to-refresh functionality
- Loading states with shimmer effects
- Error states with retry options
- Smooth animations and transitions
- Bottom navigation for easy access

## Testing

Run tests:
```bash
flutter test
```

## Known Limitations

- Free OpenWeatherMap API has rate limits (60 calls/minute)
- Location services require device GPS
- Some features require internet connection

## Future Enhancements

- Weather alerts and notifications
- Weather maps
- Historical weather data
- Multiple language support
- Weather widgets
- Offline mode with cached data

## Troubleshooting

### API Key Issues
- Ensure your API key is active (may take a few hours after creation)
- Check for any typos in the API key
- Verify your OpenWeatherMap account is verified

### Location Issues
- Enable location services on your device
- Grant location permissions to the app
- Check if GPS is working properly

### Build Issues
- Run `flutter clean` and `flutter pub get`
- Update Flutter SDK: `flutter upgrade`
- Check for dependency conflicts

## Credits

- Weather data provided by [OpenWeatherMap](https://openweathermap.org/)
- Icons from Material Design
- Built with Flutter

## License

This project is for educational purposes as part of Mobile Application Development coursework.

---

**Developer:** Hasara Sesadi
**Student ID:** E211307
**Module:** Mobile Application Development
**Institution:** Kingston University
