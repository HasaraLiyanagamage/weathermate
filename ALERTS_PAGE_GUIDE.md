# 🔔 Alerts Page - User Guide

## Overview

The Alerts Page allows you to create custom weather alerts that notify you when specific weather conditions are met. You can set thresholds for temperature, rain, wind speed, humidity, and pressure.

---

## 🎯 How to Use the Alerts Page

### 1. **Access the Alerts Page**
- Tap the **"Alerts"** tab in the bottom navigation bar (bell icon)
- You'll see a list of your existing alerts (if any)

---

### 2. **Create a New Alert**

#### Step 1: Tap the "+" Button
- Look for the floating action button (FAB) with a "+" icon
- Tap it to open the "Create Alert" dialog

#### Step 2: Select Alert Type
Choose from 5 weather alert types:

| Alert Type | Description | Example Use |
|------------|-------------|-------------|
| **Temperature** | Alert when temp reaches threshold | "Alert me when temp > 30°C" |
| **Rain** | Alert when rain is expected | "Alert me when rain is coming" |
| **Wind Speed** | Alert when wind exceeds threshold | "Alert me when wind > 20 km/h" |
| **Humidity** | Alert when humidity reaches level | "Alert me when humidity > 80%" |
| **Pressure** | Alert when pressure changes | "Alert me when pressure < 1000 hPa" |

#### Step 3: Set Threshold
- Use the **slider** to adjust the threshold value
- The value updates in real-time as you move the slider
- Default values are pre-set for each alert type

**Threshold Ranges:**
- **Temperature**: -20°C to 50°C (default: 30°C)
- **Wind Speed**: 0 to 50 km/h (default: 20 km/h)
- **Humidity**: 0% to 100% (default: 80%)
- **Pressure**: 950 to 1050 hPa (default: 1000 hPa)
- **Rain**: 0 to 100 mm (default: 50 mm)

#### Step 4: Create Alert
- Tap the **"Create"** button to save your alert
- Or tap **"Cancel"** to discard

---

### 3. **View Your Alerts**

After creating alerts, you'll see them displayed as cards:

**Each alert card shows:**
- 🎨 **Color-coded icon** (different color for each type)
- 📊 **Alert type** (Temperature, Rain, Wind, etc.)
- 🎯 **Threshold value** with unit
- 🏙️ **City name** (currently "All")
- 🕐 **Creation date**
- ⚡ **Enable/Disable toggle**

**Alert Colors:**
- 🔴 Temperature: Red/Orange
- 💧 Rain: Blue
- 💨 Wind: Cyan
- 💦 Humidity: Purple
- 🌡️ Pressure: Teal

---

### 4. **Manage Alerts**

#### Enable/Disable Alert
- Each alert has a **toggle switch**
- Tap the switch to enable or disable the alert
- Disabled alerts won't trigger notifications

#### Delete Alert
- Tap the **trash icon** on any alert card
- Confirm deletion in the dialog
- The alert will be permanently removed

---

## 📱 Example Scenarios

### Scenario 1: Hot Weather Alert
**Goal**: Get notified when it's too hot outside

1. Tap the "+" button
2. Select **"Temperature"** from dropdown
3. Move slider to **35°C**
4. Tap **"Create"**
5. ✅ You'll now be alerted when temp exceeds 35°C

### Scenario 2: Rain Alert
**Goal**: Know when to bring an umbrella

1. Tap the "+" button
2. Select **"Rain"** from dropdown
3. Set threshold to **10 mm**
4. Tap **"Create"**
5. ✅ You'll be alerted when rain exceeds 10mm

### Scenario 3: Windy Conditions
**Goal**: Alert for strong winds (cycling safety)

1. Tap the "+" button
2. Select **"Wind Speed"** from dropdown
3. Set threshold to **30 km/h**
4. Tap **"Create"**
5. ✅ You'll be alerted when wind exceeds 30 km/h

### Scenario 4: High Humidity
**Goal**: Know when it's uncomfortably humid

1. Tap the "+" button
2. Select **"Humidity"** from dropdown
3. Set threshold to **85%**
4. Tap **"Create"**
5. ✅ You'll be alerted when humidity exceeds 85%

---

## 🎨 Visual Features

### Premium Design
- ✨ **Glassmorphism cards** with frosted glass effect
- 🌈 **Color-coded alerts** for easy identification
- 📊 **Smooth animations** when creating/deleting
- 🎯 **Interactive sliders** for threshold adjustment

### Empty State
When you have no alerts:
- 📭 **Empty state illustration**
- 💡 **Helpful message**: "No alerts yet"
- 👉 **Call to action**: "Create your first weather alert"

---

## 🔧 Technical Details

### How Alerts Work

1. **Creation**
   - Alert is saved to local storage (SharedPreferences)
   - Alert data includes: type, threshold, condition, enabled status

2. **Storage**
   - Alerts persist across app sessions
   - Stored locally on your device
   - No cloud sync (privacy-focused)

3. **Checking**
   - App checks current weather against your alert thresholds
   - When threshold is met, notification is triggered
   - Only enabled alerts are checked

4. **Notifications**
   - System notifications when conditions are met
   - Includes alert type and current value
   - Tap notification to open app

---

## 📊 Alert Types Details

### 1. Temperature Alert
- **Unit**: Celsius (°C)
- **Range**: -20°C to 50°C
- **Condition**: Above threshold
- **Example**: "Alert when temp > 30°C"

### 2. Rain Alert
- **Unit**: Millimeters (mm)
- **Range**: 0 to 100 mm
- **Condition**: Above threshold
- **Example**: "Alert when rain > 10mm"

### 3. Wind Speed Alert
- **Unit**: Kilometers per hour (km/h)
- **Range**: 0 to 50 km/h
- **Condition**: Above threshold
- **Example**: "Alert when wind > 25 km/h"

### 4. Humidity Alert
- **Unit**: Percentage (%)
- **Range**: 0% to 100%
- **Condition**: Above threshold
- **Example**: "Alert when humidity > 80%"

### 5. Pressure Alert
- **Unit**: Hectopascals (hPa)
- **Range**: 950 to 1050 hPa
- **Condition**: Below threshold
- **Example**: "Alert when pressure < 1000 hPa"

---

## 💡 Tips & Best Practices

### Creating Effective Alerts

1. **Be Specific**
   - Set realistic thresholds based on your location
   - Consider seasonal variations

2. **Don't Over-Alert**
   - Too many alerts can be annoying
   - Focus on conditions that truly matter to you

3. **Test Your Alerts**
   - Create a test alert with a low threshold
   - Verify notifications are working

4. **Seasonal Adjustments**
   - Update thresholds for different seasons
   - Summer: Higher temp thresholds
   - Winter: Lower temp thresholds

### Common Use Cases

**For Outdoor Activities:**
- 🚴 Cycling: Wind speed < 20 km/h
- 🏃 Running: Temperature 15-25°C
- ⛱️ Beach: Temperature > 28°C, no rain

**For Health:**
- 🌡️ Heat sensitivity: Temperature > 32°C
- 💧 Asthma: Humidity < 60%
- 🌬️ Respiratory: Wind speed < 15 km/h

**For Planning:**
- ☔ Outdoor event: Rain < 5mm
- 🌤️ Photography: Specific light conditions
- 🏠 Home comfort: Humidity 40-60%

---

## 🎯 Quick Actions

### View All Alerts
- Scroll through your alert list
- See enabled/disabled status at a glance

### Quick Enable/Disable
- Toggle switch on each card
- Instant feedback with color change

### Quick Delete
- Tap trash icon
- Confirm deletion
- Alert removed immediately

---

## 🔮 Future Features (Planned)

Potential enhancements:
- [ ] Location-specific alerts
- [ ] Multiple conditions (AND/OR logic)
- [ ] Custom notification sounds
- [ ] Alert history
- [ ] Snooze functionality
- [ ] Alert groups/categories
- [ ] Export/import alerts
- [ ] Alert templates

---

## ❓ Troubleshooting

### Alerts Not Triggering?

**Check these:**
1. ✅ Alert is **enabled** (toggle is ON)
2. ✅ Threshold is **realistic** for your location
3. ✅ App has **notification permissions**
4. ✅ Device notifications are **not muted**
5. ✅ App is **running** (background or foreground)

### Can't Create Alert?

**Possible issues:**
1. Check internet connection (for weather data)
2. Ensure app has storage permissions
3. Try restarting the app

### Alert Deleted by Mistake?

**Solution:**
- Alerts are stored locally
- Once deleted, they cannot be recovered
- Create a new alert with same settings

---

## 📝 Summary

### Key Features
✅ **5 alert types** (Temperature, Rain, Wind, Humidity, Pressure)  
✅ **Custom thresholds** with interactive sliders  
✅ **Enable/disable** individual alerts  
✅ **Color-coded** for easy identification  
✅ **Persistent storage** across app sessions  
✅ **Premium design** with glassmorphism  
✅ **Smooth animations** and transitions  

### How It Works
1. **Create** alerts with custom thresholds
2. **Enable** alerts you want to monitor
3. **Receive** notifications when conditions are met
4. **Manage** alerts easily (enable/disable/delete)

---

## 🎉 Get Started!

**Ready to create your first alert?**

1. Open the **Alerts** tab
2. Tap the **"+"** button
3. Choose your **alert type**
4. Set your **threshold**
5. Tap **"Create"**

**That's it!** You'll now receive notifications when your weather conditions are met. 🔔✨

---

**Developer:** Hasara Sesadi  
**Student ID:** E211307  
**Feature:** Weather Alerts System  
**Status:** ✅ FULLY FUNCTIONAL  
**Last Updated:** 2025-12-02
