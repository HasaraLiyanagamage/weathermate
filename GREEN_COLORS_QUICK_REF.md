# 🎨 Green Theme - Quick Reference Card

## Color Palette

```
┌─────────────────────────────────────────────────────┐
│  GREEN COLOR PALETTE - Light to Dark               │
├─────────────────────────────────────────────────────┤
│  green1  #D8F3DC  ░░░░░░░  Lightest Mint          │
│  green2  #B7E4C7  ░░░░░░   Light Mint Green       │
│  green3  #95D5B2  ░░░░░    Medium Mint            │
│  green4  #74C69D  ░░░░     Teal Green             │
│  green5  #52B788  ░░░      Medium Teal (PRIMARY)  │
│  green6  #40916C  ░░       Deep Teal              │
│  green7  #2D6A4F  ░        Forest Green           │
│  green8  #1B4332  ▓        Dark Forest            │
│  green9  #081C15  █        Darkest Green          │
└─────────────────────────────────────────────────────┘
```

## Most Used Colors

| Color | Hex | Usage |
|-------|-----|-------|
| **green5** | #52B788 | Primary, buttons, success |
| **green1** | #D8F3DC | Backgrounds |
| **green9** | #081C15 | Text |
| **green4** | #74C69D | Secondary actions |
| **green6** | #40916C | Errors, dark elements |

## Gradients

### Default (Splash)
```
green5 → green6 → green7
#52B788 → #40916C → #2D6A4F
```

### Light (Backgrounds)
```
green1 → green2 → green3
#D8F3DC → #B7E4C7 → #95D5B2
```

### Medium (Cards)
```
green3 → green4 → green5
#95D5B2 → #74C69D → #52B788
```

### Dark (Night)
```
green7 → green8 → green9
#2D6A4F → #1B4332 → #081C15
```

## Weather Gradients

| Weather | Gradient |
|---------|----------|
| ☀️ Sunny | green1 → green3 → green5 |
| ☁️ Cloudy | green2 → green4 → green6 |
| 🌧️ Rainy | green4 → green6 → green7 |
| ❄️ Snowy | green1 → green2 → green3 |
| ⛈️ Stormy | green6 → green7 → green8 |
| 🌙 Night | green7 → green8 → green9 |

## Temperature Colors

| Temp | Color | Hex |
|------|-------|-----|
| < 0°C | green3 | #95D5B2 |
| 0-10°C | green4 | #74C69D |
| 10-20°C | green5 | #52B788 |
| 20-30°C | green6 | #40916C |
| > 30°C | green7 | #2D6A4F |

## AQI Colors

| AQI | Level | Color | Hex |
|-----|-------|-------|-----|
| 0-50 | Good | green5 | #52B788 |
| 51-100 | Moderate | green4 | #74C69D |
| 101-150 | Unhealthy (Sensitive) | green6 | #40916C |
| 151-200 | Unhealthy | green7 | #2D6A4F |
| 201-300 | Very Unhealthy | green8 | #1B4332 |
| 300+ | Hazardous | green9 | #081C15 |

## Code Examples

### Use a color
```dart
Container(color: AppColors.green5)
```

### Use a gradient
```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: AppColors.defaultGradient,
    ),
  ),
)
```

### Get weather gradient
```dart
final gradient = AppColors.getWeatherGradient('sunny', false);
```

### Get temperature color
```dart
final color = AppColors.getTemperatureColor(25.0);
```

### Get AQI color
```dart
final color = AppColors.getAQIColor(75);
```

---

**Quick Tip**: All premium widgets automatically use these colors!
