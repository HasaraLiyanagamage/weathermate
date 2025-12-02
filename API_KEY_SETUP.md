# OpenWeatherMap API Key Setup Guide

## Step 1: Create an Account

1. Go to [OpenWeatherMap](https://openweathermap.org/)
2. Click on "Sign In" in the top right corner
3. Click "Create an Account"
4. Fill in the registration form:
   - Username
   - Email
   - Password
   - Agree to terms and conditions
5. Click "Create Account"
6. Check your email and verify your account

## Step 2: Generate API Key

1. After logging in, go to your profile by clicking your username
2. Click on "My API keys" or navigate to: https://home.openweathermap.org/api_keys
3. You should see a default API key already generated
4. If not, enter a name for your API key (e.g., "WeatherMate App")
5. Click "Generate" button
6. Copy the API key (it looks like: `a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6`)

**Important Notes:**
- It may take a few hours (up to 2 hours) for the API key to become active
- Keep your API key secure and don't share it publicly
- Free tier allows 60 calls per minute and 1,000,000 calls per month

## Step 3: Add API Key to the App

### Method 1: Direct Configuration (Development)

1. Open the project in your IDE
2. Navigate to: `lib/core/constants/api_constants.dart`
3. Find the line:
   ```dart
   static const String apiKey = 'YOUR_API_KEY_HERE';
   ```
4. Replace `YOUR_API_KEY_HERE` with your actual API key:
   ```dart
   static const String apiKey = 'a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6';
   ```
5. Save the file

### Method 2: Environment Variables (Production - Recommended)

For production apps, it's better to use environment variables:

1. Create a `.env` file in the project root (add to .gitignore)
2. Add your API key:
   ```
   OPENWEATHER_API_KEY=a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6
   ```
3. Use flutter_dotenv package to load it
4. Update api_constants.dart to read from environment

## Step 4: Test the API Key

### Using Browser
Test if your API key works by visiting this URL (replace YOUR_API_KEY):
```
https://api.openweathermap.org/data/2.5/weather?q=London&appid=YOUR_API_KEY&units=metric
```

You should see a JSON response with weather data.

### Using the App
1. Run the app: `flutter run`
2. The app should automatically fetch weather for your location
3. Try searching for a city
4. If you see weather data, your API key is working!

## Troubleshooting

### Error: "Invalid API key"
- **Cause:** API key is incorrect or not yet activated
- **Solution:** 
  - Double-check you copied the entire key
  - Wait 1-2 hours for activation
  - Regenerate a new key if needed

### Error: "City not found"
- **Cause:** City name is incorrect or doesn't exist in the database
- **Solution:** 
  - Try different city name spelling
  - Use major cities for testing (London, New York, Tokyo)

### Error: "Too many requests"
- **Cause:** Exceeded the rate limit (60 calls/minute)
- **Solution:** 
  - Wait a minute before trying again
  - Implement caching in the app
  - Consider upgrading your plan

### API Key Not Working After Hours
- **Cause:** Account not verified or payment method required
- **Solution:**
  - Check your email for verification link
  - Verify your account is active
  - Check OpenWeatherMap dashboard for any issues

## API Limits (Free Tier)

- **Calls per minute:** 60
- **Calls per month:** 1,000,000
- **Forecast:** 5 days / 3-hour intervals
- **Historical data:** Not available
- **Weather alerts:** Not available

## Upgrading Your Plan

If you need more features:
1. Go to [OpenWeatherMap Pricing](https://openweathermap.org/price)
2. Choose a plan that fits your needs
3. Professional plans offer:
   - More API calls
   - 16-day forecasts
   - Historical data
   - Weather maps
   - Priority support

## Security Best Practices

### ⚠️ DO NOT:
- Commit API keys to public repositories
- Share your API key publicly
- Hardcode API keys in production apps
- Use the same key for multiple apps

### ✅ DO:
- Use environment variables
- Add .env to .gitignore
- Rotate keys periodically
- Monitor API usage
- Use different keys for dev/prod

## Example .gitignore Entry

Add this to your `.gitignore` file:
```
# API Keys and Secrets
.env
.env.local
.env.production
lib/core/constants/api_constants.dart
```

Then create a template file:
```dart
// api_constants.template.dart
class ApiConstants {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = 'YOUR_API_KEY_HERE'; // Replace with your key
  // ... rest of the constants
}
```

## Additional Resources

- [OpenWeatherMap API Documentation](https://openweathermap.org/api)
- [Current Weather API](https://openweathermap.org/current)
- [5 Day Forecast API](https://openweathermap.org/forecast5)
- [API Response Examples](https://openweathermap.org/current#example)
- [Error Codes](https://openweathermap.org/faq#error401)

## Support

If you encounter issues:
1. Check [OpenWeatherMap FAQ](https://openweathermap.org/faq)
2. Visit [OpenWeatherMap Support](https://openweathermap.org/support)
3. Check your account dashboard for any notifications
4. Contact OpenWeatherMap support team

---

**Note:** This app is for educational purposes. Always follow OpenWeatherMap's terms of service and API usage guidelines.
