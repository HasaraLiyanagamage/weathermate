# WeatherMate - Quick Start Guide

## 🚀 Get Started in 5 Minutes

### Prerequisites
- Flutter SDK installed
- Android Studio or Xcode (for mobile)
- OpenWeatherMap API key

---

## Step 1: Get Your API Key (2 minutes)

1. Visit [OpenWeatherMap](https://openweathermap.org/)
2. Sign up for a free account
3. Go to API Keys section
4. Copy your API key

**Note:** It may take 1-2 hours for the key to activate.

---

## Step 2: Configure the App (1 minute)

1. Open `lib/core/constants/api_constants.dart`
2. Replace `YOUR_API_KEY_HERE` with your actual API key:

```dart
static const String apiKey = 'your_actual_api_key_here';
```

3. Save the file

---

## Step 3: Install Dependencies (1 minute)

Open terminal in project directory and run:

```bash
flutter pub get
```

---

## Step 4: Run the App (1 minute)

### For Android:
```bash
flutter run
```

### For iOS:
```bash
cd ios
pod install
cd ..
flutter run
```

### For Web:
```bash
flutter run -d chrome
```

---

## 🎉 That's It!

The app should now be running on your device/emulator.

---

## First Time Usage

### 1. Grant Location Permission
When the app launches, it will request location permission:
- **Allow** - Get weather for your current location
- **Deny** - App will show weather for London (default)

### 2. Explore Features

**Home Tab:**
- View current weather
- Pull down to refresh
- Tap heart icon to add to favorites

**Search Tab:**
- Search any city
- View recent searches
- Quick access to popular cities

**Forecast Tab:**
- View 5-day forecast
- See temperature chart
- Expand days for hourly details

**Favorites Tab:**
- View saved cities
- Tap to see weather
- Swipe to delete

**Settings Tab:**
- Change temperature unit
- Toggle dark mode
- View app info

---

## Troubleshooting

### "Invalid API key" Error
- Wait 1-2 hours for API key activation
- Check if you copied the entire key
- Verify key in OpenWeatherMap dashboard

### Location Not Working
- Enable location services on device
- Grant location permission to app
- Check if GPS is working

### App Not Building
```bash
flutter clean
flutter pub get
flutter run
```

### Dependencies Error
```bash
flutter pub upgrade
```

---

## Building Release APK

```bash
flutter build apk --release
```

APK location: `build/app/outputs/flutter-apk/app-release.apk`

---

## Project Structure

```
lib/
├── core/               # Shared utilities
├── features/           # Feature modules
│   ├── weather/       # Current weather
│   ├── forecast/      # 5-day forecast
│   ├── favorites/     # Saved cities
│   ├── search/        # City search
│   └── settings/      # App settings
└── main.dart          # App entry point
```

---

## Key Files to Know

- `lib/main.dart` - App entry point
- `lib/core/constants/api_constants.dart` - API configuration
- `lib/core/theme/app_theme.dart` - Theme configuration
- `pubspec.yaml` - Dependencies

---

## Common Commands

```bash
# Run app
flutter run

# Build APK
flutter build apk

# Clean build
flutter clean

# Update dependencies
flutter pub upgrade

# Check for issues
flutter doctor

# Analyze code
flutter analyze

# Run tests
flutter test
```

---

## Next Steps

1. ✅ Run the app
2. ✅ Test all features
3. ✅ Add your favorite cities
4. ✅ Customize settings
5. ✅ Build release APK
6. ✅ Create demo video
7. ✅ Write documentation

---

## Resources

- [Full Documentation](README_SETUP.md)
- [Architecture Guide](ARCHITECTURE.md)
- [Features List](FEATURES.md)
- [API Setup Guide](API_KEY_SETUP.md)

---

## Support

If you encounter issues:
1. Check troubleshooting section above
2. Review full documentation
3. Check Flutter doctor: `flutter doctor`
4. Verify API key is active

---

**Happy Coding! 🎉**
