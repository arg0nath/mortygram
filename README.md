# 🛸 Mortygram

A feature-rich Flutter application that brings the Rick and Morty universe to your fingertips. Explore characters from the beloved animated series with a smooth, modern mobile experience.

## 📱 Features

- **Character Browser**: Browse through all Rick and Morty characters with paginated lazy -load lists and smooth scrolling
- **Detailed Character Profiles**: View comprehensive information about each character including species, status, origin, and location
- **Offline Support**: Access previously viewed data even without internet connection
- **Smooth Animations**: Enhanced UI with Lottie animations and Flutter Animate
- **Share Functionality**: Share your favorite characters with friends
- **Dark/Light Themes**: Flexible theming with FlexColorScheme

## 🏗️ Architecture

The app follows **Clean Architecture** principles with a clear separation of concerns:

```
lib/
├── features/          # Feature modules (characters, episodes, locations, etc.)
├── core/
│   ├── common/       # Shared utilities and constants
│   ├── database/     # Drift database implementation
│   ├── routes/       # Go Router navigation
│   └── services/     # Dependency injection and services
└── config/           # App configuration (theme, logger, etc.)
```

### Key Architectural Patterns:
- **BLoC Pattern**: State management using flutter_bloc
- **Repository Pattern**: Data layer abstraction
- **Dependency Injection**: Using GetIt for service location
- **Local Database**: Drift for offline caching and data persistence

## 🛠️ Tech Stack

### Core & State Management
- **Flutter SDK & Dart, bloc**

### Build Commands

Clean and rebuild:
```bash
flutter clean && dart run build_runner build -d && flutter pub get
```

Generate launcher icons:
```bash
flutter pub run flutter_launcher_icons
```

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- Rick and Morty API: [rickandmortyapi.com](https://rickandmortyapi.com)
- Flutter Team: For the amazing framework
- Community: For all the great packages used in this project
