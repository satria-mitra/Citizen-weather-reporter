<p align="center"><img align="center" width="300" src="./assets/"></p>
<h1 align="center"></h1>



https://weathershare.my.canva.site/
Weathershare is a crowdsourcing application that collects weather reports from many people to help verify weather forecasts. This application encourages the community to share weather conditions in their surrounding environment.

## Why bothers develop this app?

- Most weather forecast is accurate, but the real condition might be differ on each location
- Radar and satellite images are limited and cannot capture real condition on the ground within small scale
- The limited number of weather stations makes weather forecast verification slow

## Benefits
- Crowdsourcing can significantly increase the number of data points available for weather prediction
- Crowdsourcing weather data encourages community participation and engagement
- Crowdsourced data can offer real-time information on weather conditions, 


## User Persona
![User Persona](<Assets/User personas/CitizenWeatherReporter.png>)

This user persona is designed using [Xtensio](https://xtensio.com/).


## Mock-up Design

This is the mock-up design of each section of the page, visualising the user experience through the app's funcionality.

![Quick prototyping](Assets/Sketches/IMG_2303.jpg)

![Wireframe](<Assets/Sketches/Screenshot 2024-02-06 at 08.29.08.png>)

Designed on [mockup](https://getmockup.app/) app.

## Screens

<table>
  <tr>
    <!-- Image 1 -->
    <td>
      <p align="center" style="font-size: 16px; font-weight: bold;">Instant scan with minimum interaction</p>
      <img src="github_assets\gif\savetodb.gif" alt="Instant scan with minimum interaction" width="300">
      <br>
    </td>
    <!-- Image 2 -->
    <td>
      <p align="center" style="font-size: 16px; font-weight: bold;">Notification dialog for scan errors</p>
      <img src="github_assets\gif\duplicate.gif" alt="Notification dialog for scan errors" width="300">
      <br>
    </td>
    <!-- Image 3 -->
    <td>
      <p align="center" style="font-size: 16px; font-weight: bold;">Search scanned LFT based on label and ID</p>
      <img src="github_assets\gif\search.gif" alt="Search scanned LFT based on label and ID" width="300">
      <br>
    </td>
  </tr>
</table>

<table>
  <tr>
    <!-- Image 1 -->
    <td>
      <p align="center" style="font-size: 16px; font-weight: bold;">Filter based on date or date range</p>
      <img src="github_assets\gif\date.gif" alt="Instant scan with minimum interaction" width="300">
      <br>
    </td>
    <!-- Image 2 -->
    <td>
      <p align="center" style="font-size: 16px; font-weight: bold;">Convert LFT results to CSV</p>
      <img src="github_assets\gif\csv.gif" alt="Notification dialog for scan errors" width="300">
      <br>
    </td>
    <!-- Image 3 -->
    <td>
      <p align="center" style="font-size: 16px; font-weight: bold;">Switch to Darkmode for better readability</p>
      <img src="github_assets\gif\darkmode.gif" alt="Search scanned LFT based on label and ID" width="300">
      <br>
    </td>
  </tr>
</table>


## Technologies behind this app
 ✅ Flutter SDK
 ✅ Firebase
 ✅ Google Maps API
 ✅ BMKG MQTT Weather Station

## Dependencies

  1. camera: ^0.10.5+9
  2. change_app_package_name: ^1.1.0
  3. cloud_firestore: ^4.16.1
  4. firebase_auth: ^4.19.1
  5. firebase_core: ^2.29.0
  6. firebase_database: ^10.5.2
  7. firebase_storage: ^11.7.1
  8. firebase_ui_auth: ^1.13.1
  9. flutter:
    sdk: flutter
10. flutter_native_splash: ^2.4.0
11. geolocator: ^11.0.0
  12. get: ^4.6.6
  13. get_storage: ^2.1.1
  14. google_fonts: ^6.2.0
  15. google_maps_flutter: ^2.2.8
  16. google_sign_in: ^6.2.1
  17. image_picker: ^1.1.0
  18. smooth_page_indicator: ^1.1.0

## Development Environment

```
$ flutter --version
Flutter 3.19.5 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 300451adae (4 weeks ago) • 2024-03-27 21:54:07 -0500
Engine • revision e76c956498
Tools • Dart 3.3.3 • DevTools 2.31.1
```

## Installation

Pre-requirements:

- Install Flutter and Dart
- Install simulation device or
- Have a phone plugged to the main machine

```
$ git clone https://github.com/satria-mitra/weathershare.git
$ cd weathershare
$ flutter pub get
$ flutter run
```


##  Contact Details

Satria Mitra Utama
satriamitrautama@gmail.com 
Currently a student at Master of Connected Environment UCL
