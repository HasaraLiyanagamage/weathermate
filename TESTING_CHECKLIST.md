# WeatherMate - Testing Checklist

## Pre-Testing Setup
- [x] API key configured in `lib/core/constants/api_constants.dart`
- [x] Dependencies installed (`flutter pub get`)
- [x] No compilation errors (`flutter analyze` shows only deprecation warnings)

## Feature Testing

### 1. Home Page - Location-Based Weather
- [ ] App launches successfully
- [ ] Location permission requested on first launch
- [ ] Current location weather displayed automatically
- [ ] Weather information shows:
  - [ ] City name and country
  - [ ] Current temperature
  - [ ] Weather condition with icon
  - [ ] Feels like temperature
  - [ ] Min/max temperatures
  - [ ] Humidity percentage
  - [ ] Wind speed
  - [ ] Pressure
  - [ ] Visibility
  - [ ] Sunrise time
  - [ ] Sunset time
- [ ] Pull-to-refresh updates weather data
- [ ] Favorite button works (add/remove)
- [ ] Refresh button reloads current location
- [ ] Error handling works when location unavailable
- [ ] Default city (London) loads when location denied

### 2. Search Page - City Search with Region Filter
- [ ] Search page accessible from bottom navigation
- [ ] Search field accepts text input
- [ ] Search by city name works correctly
- [ ] Recent searches displayed (up to 10)
- [ ] Recent search chips clickable
- [ ] Region filter dropdown shows all regions:
  - [ ] All
  - [ ] Europe
  - [ ] Asia
  - [ ] Americas
  - [ ] Oceania
  - [ ] Africa
- [ ] Popular cities list updates based on selected region
- [ ] Clicking popular city loads weather
- [ ] Weather results display correctly
- [ ] Error message shown for invalid city
- [ ] Clear button removes search text

### 3. Forecast Page - 5-Day Weather Forecast
- [ ] Forecast page accessible from bottom navigation
- [ ] Forecast loads for current location/selected city
- [ ] Temperature chart displays correctly
- [ ] Chart shows 8 data points (next 24 hours)
- [ ] Chart has proper axis labels
- [ ] Daily forecast cards displayed (5 days)
- [ ] Each day shows:
  - [ ] Day of week
  - [ ] Date
  - [ ] Weather icon
  - [ ] Max temperature
  - [ ] Min temperature
- [ ] Expandable cards show hourly details:
  - [ ] Time
  - [ ] Weather icon
  - [ ] Description
  - [ ] Temperature
  - [ ] Humidity
- [ ] Pull-to-refresh updates forecast
- [ ] Refresh button works

### 4. Favorites Page - Saved Cities
- [ ] Favorites page accessible from bottom navigation
- [ ] Empty state shown when no favorites
- [ ] Add favorite from home page works
- [ ] Favorite cities list displayed
- [ ] Each favorite shows:
  - [ ] City name
  - [ ] Country
  - [ ] Location icon
- [ ] Clicking favorite navigates to home with that city's weather
- [ ] Delete button shows confirmation dialog
- [ ] Confirm delete removes city from favorites
- [ ] Cancel delete keeps city in favorites
- [ ] Pull-to-refresh reloads favorites list
- [ ] Favorites persist after app restart

### 5. Alerts Page - Weather Alerts (NEW)
- [ ] Alerts page accessible from bottom navigation
- [ ] Empty state shown when no alerts
- [ ] Add alert button (+) opens dialog
- [ ] Alert creation dialog shows:
  - [ ] City name input field
  - [ ] Alert type dropdown (Temperature, Humidity, Wind, Rain, Snow)
  - [ ] Condition dropdown (Above, Below) - for applicable types
  - [ ] Threshold input field - for applicable types
- [ ] Create button adds alert
- [ ] Alert card displays:
  - [ ] City name
  - [ ] Alert description
  - [ ] Enable/disable toggle
  - [ ] Menu button
- [ ] Toggle switch enables/disables alert
- [ ] Menu shows delete option
- [ ] Delete shows confirmation dialog
- [ ] Alerts persist after app restart
- [ ] Different alert types show correct icons:
  - [ ] Temperature (thermometer)
  - [ ] Humidity (water drop)
  - [ ] Wind (air icon)
  - [ ] Rain (umbrella)
  - [ ] Snow (snowflake)

### 6. Settings Page - App Configuration
- [ ] Settings page accessible from bottom navigation
- [ ] General section shows:
  - [ ] Temperature unit toggle (Celsius/Fahrenheit)
  - [ ] Dark mode toggle
- [ ] Temperature unit toggle works
- [ ] Dark mode toggle works
- [ ] About section shows:
  - [ ] App version (1.0.0)
  - [ ] App name (WeatherMate)
  - [ ] Data source (OpenWeatherMap API)
- [ ] Support section shows:
  - [ ] Report a Bug
  - [ ] Rate the App
  - [ ] Share the App
- [ ] Legal section shows:
  - [ ] Privacy Policy
  - [ ] Terms of Service
- [ ] Placeholder items show "Coming Soon" dialog
- [ ] Settings persist after app restart

## Navigation Testing
- [ ] Bottom navigation bar shows 6 tabs:
  - [ ] Home
  - [ ] Search
  - [ ] Forecast
  - [ ] Favorites
  - [ ] Alerts
  - [ ] Settings
- [ ] All tabs accessible
- [ ] Tab selection highlights correctly
- [ ] Tab icons change when selected
- [ ] State maintained when switching tabs
- [ ] No crashes during navigation

## API Integration Testing
- [ ] Weather API calls successful
- [ ] Forecast API calls successful
- [ ] API responses parsed correctly
- [ ] Network errors handled gracefully
- [ ] Timeout errors handled (30 seconds)
- [ ] Invalid API responses handled
- [ ] Loading indicators shown during API calls
- [ ] Error messages user-friendly

## Data Persistence Testing
- [ ] Favorites saved locally
- [ ] Favorites loaded on app restart
- [ ] Alerts saved locally
- [ ] Alerts loaded on app restart
- [ ] Settings saved locally
- [ ] Settings loaded on app restart
- [ ] Recent searches maintained (in-memory)

## UI/UX Testing
- [ ] App theme consistent throughout
- [ ] Material Design 3 components used
- [ ] Colors appropriate for weather conditions
- [ ] Icons clear and recognizable
- [ ] Text readable and properly sized
- [ ] Buttons touch-friendly (adequate size)
- [ ] Spacing and padding consistent
- [ ] Cards have proper elevation
- [ ] Animations smooth
- [ ] Loading states clear
- [ ] Error states informative
- [ ] Empty states helpful

## Performance Testing
- [ ] App launches quickly
- [ ] API calls complete in reasonable time
- [ ] No lag when switching tabs
- [ ] Scrolling smooth
- [ ] No memory leaks
- [ ] No excessive battery drain
- [ ] Chart rendering smooth

## Error Handling Testing
- [ ] No internet connection handled
- [ ] Invalid city name handled
- [ ] Location permission denied handled
- [ ] Location services disabled handled
- [ ] API errors displayed properly
- [ ] App doesn't crash on errors
- [ ] Retry mechanisms work

## Edge Cases
- [ ] Very long city names handled
- [ ] Special characters in city names
- [ ] Multiple rapid API calls
- [ ] Switching tabs during loading
- [ ] App backgrounding/foregrounding
- [ ] Low memory conditions
- [ ] Slow network conditions

## Hardcoded Functions Verification
- [ ] All 48 popular cities work correctly
- [ ] Region filtering shows correct cities
- [ ] Default city (London) loads properly
- [ ] Weather color mapping works
- [ ] Weather icons display correctly
- [ ] Date/time formatting correct
- [ ] Temperature conversions accurate
- [ ] All alert types function properly

## Final Checks
- [ ] No console errors
- [ ] No warnings (except deprecations)
- [ ] App stable for extended use
- [ ] All features accessible
- [ ] Documentation accurate
- [ ] Code follows best practices
- [ ] Ready for demonstration
- [ ] Ready for APK build

## Build Testing
- [ ] Debug build works: `flutter build apk --debug`
- [ ] Release build works: `flutter build apk --release`
- [ ] APK installs on device
- [ ] APK runs without issues
- [ ] APK size reasonable

## Notes
- Deprecation warnings are acceptable (Flutter SDK updates)
- All core features implemented and functional
- Clean Architecture properly implemented
- Provider state management working correctly
- Third-party libraries integrated successfully
