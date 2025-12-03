# 🌿 WeatherMate - Green Theme Design System

## Overview

Your entire WeatherMate app has been transformed with a beautiful, cohesive green color palette. This design system creates a fresh, natural, and calming aesthetic perfect for a weather application.

---

## 🎨 Color Palette

Based on your provided design, the app uses a 9-color green gradient system:

### Core Green Palette (Light → Dark)

| Color | Hex Code | Name | Usage |
|-------|----------|------|-------|
| **green1** | `#D8F3DC` | Lightest Mint | Backgrounds, light surfaces |
| **green2** | `#B7E4C7` | Light Mint Green | Secondary backgrounds, snowy weather |
| **green3** | `#95D5B2` | Medium Mint | Sunny weather, info messages |
| **green4** | `#74C69D` | Teal Green | Warnings, temperature indicators |
| **green5** | `#52B788` | Medium Teal | **Primary color**, success states |
| **green6** | `#40916C` | Deep Teal | Rainy weather, errors |
| **green7** | `#2D6A4F` | Forest Green | Primary dark, stormy weather |
| **green8** | `#1B4332` | Dark Forest | Dark surfaces, accents |
| **green9** | `#081C15` | Darkest Green | Text, dark backgrounds |

---

## 🌈 Gradient System

### Weather-Based Gradients

All weather conditions now use beautiful green gradients:

#### ☀️ Sunny Gradient
```dart
[#D8F3DC → #95D5B2 → #52B788]
Light mint → Medium mint → Medium teal
```
**Usage**: Clear/sunny weather conditions

#### ☁️ Cloudy Gradient
```dart
[#B7E4C7 → #74C69D → #40916C]
Light mint green → Teal green → Deep teal
```
**Usage**: Cloudy weather conditions

#### 🌧️ Rainy Gradient
```dart
[#74C69D → #40916C → #2D6A4F]
Teal green → Deep teal → Forest green
```
**Usage**: Rain/drizzle conditions

#### ❄️ Snowy Gradient
```dart
[#D8F3DC → #B7E4C7 → #95D5B2]
Lightest mint → Light mint green → Medium mint
```
**Usage**: Snow conditions

#### ⛈️ Stormy Gradient
```dart
[#40916C → #2D6A4F → #1B4332]
Deep teal → Forest green → Dark forest
```
**Usage**: Thunderstorm conditions

#### 🌙 Night Gradient
```dart
[#2D6A4F → #1B4332 → #081C15]
Forest green → Dark forest → Darkest green
```
**Usage**: Night time (before sunrise/after sunset)

### Background Gradients

#### Default Gradient
```dart
[#52B788 → #40916C → #2D6A4F]
Medium teal → Deep teal → Forest green
```
**Usage**: Splash screen, default backgrounds

#### Light Gradient
```dart
[#D8F3DC → #B7E4C7 → #95D5B2]
Lightest mint → Light mint green → Medium mint
```
**Usage**: Light mode backgrounds

#### Medium Gradient
```dart
[#95D5B2 → #74C69D → #52B788]
Medium mint → Teal green → Medium teal
```
**Usage**: Card backgrounds

#### Dark Gradient
```dart
[#40916C → #2D6A4F → #1B4332]
Deep teal → Forest green → Dark forest
```
**Usage**: Dark mode backgrounds

---

## 📱 Screen-by-Screen Color Usage

### 1. Splash Screen
- **Background**: Default gradient (`green5 → green6 → green7`)
- **Icon**: White
- **Text**: White
- **Decorative circles**: White with 5% opacity

### 2. Home Page
- **App Bar**: Weather-based gradient
- **Weather Card**: Weather-based gradient with glassmorphism
- **Detail Cards**: Medium gradient with glassmorphism
- **Hourly Forecast**: Light gradient backgrounds
- **Air Quality**: Green scale based on AQI level

### 3. Search Page
- **Background**: Light gradient (`green1 → green2 → green3`)
- **Search Bar**: `green2` with white text
- **Region Chips**: `green4` when selected, `green2` when unselected
- **City Cards**: Medium gradient with glassmorphism
- **Recent Searches**: `green3` chips

### 4. Forecast Page
- **Background**: Light gradient
- **Temperature Chart**: `green5` line with `green3` fill
- **Daily Cards**: Medium gradient with glassmorphism
- **Hourly Breakdown**: `green2` backgrounds

### 5. Favorites Page
- **Background**: Light gradient
- **Favorite Cards**: Medium gradient with glassmorphism
- **Add Button**: `green5` primary color
- **Delete Icons**: `green6` error color

### 6. Alerts Page
- **Background**: Light gradient
- **Alert Cards**: Color-coded with green scale
  - Temperature: `green5`
  - Rain: `green6`
  - Wind: `green4`
  - Humidity: `green3`
  - AQI: `green7`
- **Create Button**: `green5` primary color

### 7. Settings Page
- **Background**: Light gradient
- **Section Cards**: `green2` with glassmorphism
- **Toggle Switches**: `green5` when active
- **List Tiles**: `green1` backgrounds

---

## 🎯 Color Usage Guidelines

### Primary Actions
- **Color**: `green5` (#52B788)
- **Usage**: Buttons, FABs, active states, success messages

### Secondary Actions
- **Color**: `green4` (#74C69D)
- **Usage**: Secondary buttons, warnings, highlights

### Error States
- **Color**: `green6` (#40916C)
- **Usage**: Error messages, delete actions, critical warnings

### Info Messages
- **Color**: `green3` (#95D5B2)
- **Usage**: Information cards, tips, neutral messages

### Text Colors

#### Light Mode
- **Primary Text**: `green9` (#081C15) - Darkest green
- **Secondary Text**: `green8` (#1B4332) - Dark forest
- **Hint Text**: `green4` (#74C69D) - Teal green
- **On Dark Backgrounds**: White (#FFFFFF)

#### Dark Mode
- **Primary Text**: White (#FFFFFF)
- **Secondary Text**: `green1` (#D8F3DC) - Light text on dark green
- **Hint Text**: `green3` (#95D5B2)

### Backgrounds

#### Light Mode
- **Main Background**: `green1` (#D8F3DC)
- **Surface**: `green2` (#B7E4C7)
- **Cards**: `green1` (#D8F3DC)

#### Dark Mode
- **Main Background**: `green9` (#081C15)
- **Surface**: `green8` (#1B4332)
- **Cards**: `green7` (#2D6A4F)

---

## 🌡️ Temperature Color Scale

Temperature indicators use the green scale:

| Temperature | Color | Hex Code | Description |
|-------------|-------|----------|-------------|
| < 0°C | `green3` | #95D5B2 | Cold - Light mint |
| 0-10°C | `green4` | #74C69D | Cool - Teal green |
| 10-20°C | `green5` | #52B788 | Mild - Medium teal |
| 20-30°C | `green6` | #40916C | Warm - Deep teal |
| > 30°C | `green7` | #2D6A4F | Hot - Forest green |

---

## 💨 Air Quality Index (AQI) Colors

AQI indicators use the green scale from light to dark:

| AQI Range | Level | Color | Hex Code |
|-----------|-------|-------|----------|
| 0-50 | Good | `green5` | #52B788 |
| 51-100 | Moderate | `green4` | #74C69D |
| 101-150 | Unhealthy for Sensitive | `green6` | #40916C |
| 151-200 | Unhealthy | `green7` | #2D6A4F |
| 201-300 | Very Unhealthy | `green8` | #1B4332 |
| 300+ | Hazardous | `green9` | #081C15 |

---

## ✨ Glassmorphism Effects

All cards use glassmorphism with green tints:

```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        green3.withOpacity(0.2),
        green4.withOpacity(0.1),
      ],
    ),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(
      color: Colors.white.withOpacity(0.2),
    ),
  ),
  child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    child: // Your content
  ),
)
```

---

## 🎨 Design Principles

### 1. Consistency
- All screens use the same green palette
- Gradients flow in the same direction (top-left to bottom-right)
- Spacing and padding are consistent

### 2. Hierarchy
- Darker greens (`green7-green9`) for important elements
- Lighter greens (`green1-green3`) for backgrounds
- Medium greens (`green4-green6`) for interactive elements

### 3. Accessibility
- High contrast between text and backgrounds
- `green9` text on `green1` backgrounds (AAA rating)
- White text on `green6-green9` backgrounds

### 4. Natural Flow
- Light to dark gradients create depth
- Green palette evokes nature and weather
- Smooth transitions between states

---

## 📊 Color Distribution

### Across the App
- **Backgrounds**: 40% (green1, green2)
- **Interactive Elements**: 30% (green4, green5, green6)
- **Text**: 20% (green8, green9, white)
- **Accents**: 10% (green3, green7)

### Per Screen
- **Light backgrounds**: green1, green2 (60%)
- **Medium elements**: green3, green4, green5 (30%)
- **Dark accents**: green6, green7, green8 (10%)

---

## 🔧 Implementation

### Using Colors in Code

```dart
// Import the color system
import 'package:weathermate/core/theme/app_colors.dart';

// Use individual colors
Container(
  color: AppColors.green5, // Primary green
)

// Use gradients
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: AppColors.defaultGradient,
    ),
  ),
)

// Get weather-based gradient
final gradient = AppColors.getWeatherGradient('sunny', false);

// Get temperature color
final tempColor = AppColors.getTemperatureColor(25.0);

// Get AQI color
final aqiColor = AppColors.getAQIColor(75);
```

---

## 🎯 Benefits of This Color System

### 1. **Cohesive Design**
- Entire app uses one harmonious palette
- Professional and polished appearance
- Consistent user experience

### 2. **Natural Aesthetic**
- Green evokes nature, weather, and freshness
- Calming and pleasant to use
- Perfect for a weather app

### 3. **Flexible**
- 9 shades provide enough variety
- Easy to add new features
- Scalable for future updates

### 4. **Accessible**
- High contrast ratios
- Color-blind friendly (uses lightness variations)
- Readable in all lighting conditions

### 5. **Modern**
- Gradient-based design is trendy
- Glassmorphism adds depth
- iOS/Material Design compatible

---

## 📱 Visual Examples

### Gradient Combinations

**Light & Airy** (Backgrounds)
```
green1 → green2 → green3
#D8F3DC → #B7E4C7 → #95D5B2
```

**Balanced** (Cards)
```
green3 → green4 → green5
#95D5B2 → #74C69D → #52B788
```

**Rich & Deep** (Headers)
```
green5 → green6 → green7
#52B788 → #40916C → #2D6A4F
```

**Dark & Dramatic** (Night mode)
```
green7 → green8 → green9
#2D6A4F → #1B4332 → #081C15
```

---

## 🚀 Quick Reference

### Most Used Colors

1. **green5** (#52B788) - Primary color, buttons, success
2. **green1** (#D8F3DC) - Light backgrounds
3. **green9** (#081C15) - Primary text
4. **green4** (#74C69D) - Secondary actions
5. **green6** (#40916C) - Errors, dark elements

### Most Used Gradients

1. **Medium Gradient** - Cards and containers
2. **Light Gradient** - Page backgrounds
3. **Default Gradient** - Splash screen, primary surfaces
4. **Weather Gradients** - Dynamic based on conditions

---

## ✅ Checklist

All screens now use the green theme:

- [x] Splash Screen - Default gradient
- [x] Home Page - Weather gradients
- [x] Search Page - Light gradient
- [x] Forecast Page - Light gradient with green charts
- [x] Favorites Page - Medium gradient cards
- [x] Alerts Page - Color-coded green alerts
- [x] Settings Page - Light gradient with green toggles

All components updated:

- [x] Weather cards - Weather gradients
- [x] Detail cards - Medium gradients
- [x] Hourly forecast - Light backgrounds
- [x] Air quality - Green scale
- [x] Temperature chart - Green line
- [x] Buttons - Primary green
- [x] Text - Green scale
- [x] Icons - Green tints

---

## 🎨 Design Philosophy

**"Fresh, Natural, Harmonious"**

The green color palette was chosen to:
- Reflect the natural world and weather
- Create a calming, trustworthy experience
- Provide a unique identity for WeatherMate
- Ensure accessibility and readability
- Support both light and dark modes

---

**Developer:** Hasara Sesadi  
**Student ID:** E211307  
**Theme Version:** 1.0.0  
**Last Updated:** 2025-12-02  
**Color Palette:** 9-Color Green Gradient System
