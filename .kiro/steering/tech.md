# Technology Stack

## Framework & Language
- **Flutter**: >=1.17.0
- **Dart**: >=3.0.0 <4.0.0
- **Package Type**: Flutter package/library

## Core Dependencies

### State Management & Architecture
- `bloc: ^8.1.4` - Business Logic Component pattern
- `flutter_bloc: ^8.1.6` - Flutter integration for BLoC

### Firebase Integration
- `firebase_core: ^3.6.0` - Firebase core functionality
- `firebase_auth: ^5.3.1` - Authentication services
- `firebase_crashlytics: ^4.1.3` - Crash reporting
- `firebase_messaging: ^15.1.3` - Push notifications

### UI & Animation
- `flutter_animate: ^4.5.0` - Animation utilities
- `lottie: ^3.1.3` - Lottie animations
- `cached_network_image: ^3.4.1` - Image caching
- `card_swiper: ^3.0.1` - Card swiping components
- `pie_chart: ^5.4.0` - Chart widgets

### Forms & Input
- `pinput: ^5.0.0` - PIN input widgets
- `day_night_time_picker: ^1.3.1` - Time picker
- `image_picker: ^1.1.2` - Image selection

### Utilities
- `intl: ^0.19.0` - Internationalization
- `shared_preferences: ^2.3.3` - Local storage
- `permission_handler: ^11.3.1` - Device permissions
- `geolocator: ^13.0.1` - Location services
- `url_launcher: ^6.3.1` - External URL handling

## Development Tools
- `flutter_lints: ^5.0.0` - Dart/Flutter linting rules
- `flutter_test` - Testing framework

## Build & Development Commands

### Package Development
```bash
# Get dependencies
flutter pub get

# Run static analysis
flutter analyze

# Run tests
flutter test

# Format code
dart format .

# Check for outdated dependencies
flutter pub outdated

# Publish package (dry run)
flutter pub publish --dry-run

# Publish package
flutter pub publish
```

### Code Quality
- Uses `package:flutter_lints/flutter.yaml` for linting
- Follows Flutter package conventions
- Includes comprehensive documentation in README.md

## Asset Management
- Lottie animations stored in `assets/json/`
- Assets declared in `pubspec.yaml` under flutter section
