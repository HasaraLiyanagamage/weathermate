# WeatherMate - Architecture Documentation

## Overview

WeatherMate is built using **Clean Architecture** principles with a feature-based folder structure. This architecture ensures separation of concerns, testability, and maintainability.

## Architecture Layers

### 1. Presentation Layer
**Location:** `lib/features/*/presentation/`

**Responsibilities:**
- UI rendering
- User interaction handling
- State management with Provider
- Navigation

**Components:**
- **Pages:** Full screen widgets (HomePage, SearchPage, ForecastPage, etc.)
- **Widgets:** Reusable UI components (WeatherInfoCard, WeatherDetailCard)
- **Providers:** State management using ChangeNotifier pattern

**Example:**
```dart
WeatherProvider (ChangeNotifier)
    ↓
WeatherRepository (interface)
    ↓
Fetches WeatherEntity
    ↓
Updates UI via notifyListeners()
```

### 2. Domain Layer
**Location:** `lib/features/*/domain/`

**Responsibilities:**
- Business logic
- Entity definitions
- Repository interfaces (contracts)

**Components:**
- **Entities:** Pure Dart objects representing business models
- **Repositories:** Abstract interfaces defining data operations
- **Use Cases:** (Can be added for complex business logic)

**Example:**
```dart
abstract class WeatherRepository {
  Future<WeatherEntity> getCurrentWeather(String cityName);
  Future<WeatherEntity> getCurrentWeatherByCoordinates(double lat, double lon);
}
```

### 3. Data Layer
**Location:** `lib/features/*/data/`

**Responsibilities:**
- Data fetching and storage
- API communication
- Local database operations
- Data transformation

**Components:**
- **Models:** Data transfer objects with JSON serialization
- **Data Sources:** Remote (API) and Local (SharedPreferences)
- **Repository Implementations:** Concrete implementations of domain interfaces

**Example:**
```dart
WeatherRepositoryImpl implements WeatherRepository
    ↓
Uses WeatherRemoteDataSource
    ↓
Makes API calls via Dio
    ↓
Returns WeatherModel (extends WeatherEntity)
```

### 4. Core Layer
**Location:** `lib/core/`

**Responsibilities:**
- Shared utilities
- Constants
- Theme configuration
- Dependency injection

**Components:**
- **Constants:** API endpoints, app constants
- **Theme:** Material Design theme configuration
- **Utils:** Helper functions (date formatting, weather utilities)
- **DI:** Dependency injection container

## Data Flow

### Example: Fetching Current Weather

```
User Action (Search City)
    ↓
UI Layer (SearchPage)
    ↓
Provider (WeatherProvider.getWeatherByCity())
    ↓
Repository Interface (WeatherRepository)
    ↓
Repository Implementation (WeatherRepositoryImpl)
    ↓
Data Source (WeatherRemoteDataSource)
    ↓
HTTP Client (Dio)
    ↓
OpenWeatherMap API
    ↓
JSON Response
    ↓
WeatherModel.fromJson()
    ↓
WeatherEntity (returned to Provider)
    ↓
Provider.notifyListeners()
    ↓
UI Updates (Consumer<WeatherProvider>)
```

## State Management

### Provider Pattern

The app uses the Provider package for state management:

**Providers:**
1. **WeatherProvider** - Manages current weather state
2. **ForecastProvider** - Manages forecast data state
3. **FavoritesProvider** - Manages favorite cities state

**States:**
- `initial` - No data loaded yet
- `loading` - Data is being fetched
- `loaded` - Data successfully loaded
- `error` - Error occurred during fetch

**Example Usage:**
```dart
Consumer<WeatherProvider>(
  builder: (context, weatherProvider, child) {
    if (weatherProvider.isLoading) {
      return CircularProgressIndicator();
    }
    if (weatherProvider.hasData) {
      return WeatherInfoCard(weather: weatherProvider.weather!);
    }
    return ErrorWidget();
  },
)
```

## Dependency Injection

**Location:** `lib/core/di/injection_container.dart`

All dependencies are initialized at app startup:

```dart
void main() async {
  await InjectionContainer.init();
  runApp(MyApp());
}
```

**Initialized Components:**
- Dio HTTP client
- SharedPreferences
- Data sources
- Repositories
- Providers

## Feature Structure

Each feature follows the same structure:

```
feature_name/
├── data/
│   ├── datasources/
│   │   ├── feature_remote_datasource.dart
│   │   └── feature_local_datasource.dart
│   ├── models/
│   │   └── feature_model.dart
│   └── repositories/
│       └── feature_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── feature_entity.dart
│   └── repositories/
│       └── feature_repository.dart
└── presentation/
    ├── pages/
    │   └── feature_page.dart
    ├── providers/
    │   └── feature_provider.dart
    └── widgets/
        └── feature_widget.dart
```

## Key Design Patterns

### 1. Repository Pattern
Abstracts data sources from business logic:
- Domain layer defines interfaces
- Data layer provides implementations
- Easy to swap data sources (API, local DB, mock)

### 2. Provider Pattern (MVVM-like)
- View observes ViewModel (Provider)
- ViewModel holds state and business logic
- Separation of UI and logic

### 3. Dependency Injection
- Centralized dependency management
- Easy testing with mock implementations
- Loose coupling between layers

### 4. Factory Pattern
Used in model classes for JSON parsing:
```dart
factory WeatherModel.fromJson(Map<String, dynamic> json) {
  return WeatherModel(...);
}
```

## API Integration

### OpenWeatherMap API

**Base URL:** `https://api.openweathermap.org/data/2.5`

**Endpoints Used:**
1. `/weather` - Current weather data
   - Query by city name: `?q=London&appid=KEY&units=metric`
   - Query by coordinates: `?lat=51.5&lon=-0.1&appid=KEY&units=metric`

2. `/forecast` - 5-day forecast (3-hour intervals)
   - Query by city name: `?q=London&appid=KEY&units=metric`
   - Query by coordinates: `?lat=51.5&lon=-0.1&appid=KEY&units=metric`

**Error Handling:**
- 404: City not found
- 401: Invalid API key
- Network errors: Connection issues
- Timeout errors: Request timeout

## Local Storage

**SharedPreferences** is used for:
- Favorite cities list
- Last known location
- User preferences (temperature unit, theme)

**Storage Keys:**
- `favorite_cities` - JSON array of favorite cities
- `last_location` - Last known GPS coordinates
- `temperature_unit` - Celsius/Fahrenheit preference
- `theme_mode` - Light/Dark theme preference

## Navigation

**Bottom Navigation Bar** with 5 tabs:
1. Home - Current weather
2. Search - City search
3. Forecast - 5-day forecast
4. Favorites - Saved cities
5. Settings - App settings

**Navigation Pattern:**
- IndexedStack for tab persistence
- State is maintained across tab switches

## UI/UX Design

### Material Design 3
- Modern, clean interface
- Consistent spacing and typography
- Elevation and shadows for depth
- Color scheme based on weather conditions

### Responsive Design
- Adapts to different screen sizes
- Flexible layouts with Column/Row
- ScrollView for content overflow

### Loading States
- CircularProgressIndicator for loading
- Shimmer effects (can be added)
- Pull-to-refresh functionality

### Error Handling
- User-friendly error messages
- Retry buttons
- Fallback to default values

## Testing Strategy

### Unit Tests
- Test business logic in providers
- Test data transformations in models
- Test utility functions

### Widget Tests
- Test individual widgets
- Test user interactions
- Test state changes

### Integration Tests
- Test complete user flows
- Test API integration
- Test navigation

## Performance Considerations

1. **Lazy Loading:** Data fetched only when needed
2. **Caching:** SharedPreferences for offline access
3. **Efficient Rebuilds:** Consumer widgets rebuild only affected parts
4. **Image Optimization:** Weather icons from API
5. **Network Optimization:** Dio with timeout configurations

## Security Considerations

1. **API Key:** Should be stored securely (environment variables in production)
2. **HTTPS:** All API calls use secure connections
3. **Permissions:** Location permissions requested at runtime
4. **Data Validation:** Input validation before API calls

## Scalability

The architecture supports easy addition of:
- New features (just add new feature folder)
- New data sources (implement repository interface)
- New state management (replace providers)
- New UI themes
- Internationalization (i18n)

## Future Enhancements

1. **Use Cases Layer:** Add for complex business logic
2. **Offline Mode:** Cache weather data locally
3. **Push Notifications:** Weather alerts
4. **Weather Maps:** Visual weather representation
5. **Historical Data:** Past weather trends
6. **Multiple Languages:** i18n support
7. **Unit Tests:** Comprehensive test coverage
8. **CI/CD:** Automated testing and deployment

## Conclusion

This architecture provides:
- ✅ Clear separation of concerns
- ✅ Easy to test and maintain
- ✅ Scalable and extensible
- ✅ Following industry best practices
- ✅ Clean and readable code structure
