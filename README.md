# Country Info App 🌍

![Flutter](https://img.shields.io/badge/Flutter-3.24.3-blue)
![Dart](https://img.shields.io/badge/Dart-3.5.3-blue)
![License](https://img.shields.io/badge/License-MIT-green)

A modern mobile application providing comprehensive information about countries worldwide. Built with Flutter, this app delivers detailed country data through a clean, intuitive interface with customizable theming options.

## ✨ Key Features

* **Country Database**
  * Extensive country listing with detailed information
  * Powerful search and filtering capabilities

* **Country Details**
  * Official names and flag displays
  * Country codes and identifiers
  * Capital cities
  * Population data
  * Continental grouping
  * Administrative regions
  * Current leadership

* **User Experience**
  * Fast, intuitive search
  * Light and dark themes
  * Responsive layouts
  * Offline data access
  * Fluid animations

📱 App Preview
Light Theme
<p float="left">
  <img src="flutter_01.png" width="160" />
  <img src="flutter_02.png" width="160" /> 
  <img src="flutter_03.png" width="160" />
</p>
Left to Right: Welcome Screen, Countries List, Country Details
Dark Theme
<p float="left">
  <img src="flutter_04.png" width="160" />
  <img src="flutter_05.png" width="160" />
</p>
Left to Right: Countries List, Country Details

## 🛠️ Technology Stack

### Core Platform
* Flutter Framework
* Dart Programming Language

### Dependencies
* `flutter_riverpod`: ^2.6.1 - State management
* `google_fonts`: ^6.2.1 - Typography
* `dio`: ^5.8.0+1 - HTTP client

## 🚀 Setup Guide

### Requirements
1. Flutter SDK (3.24.3+)
2. Dart SDK (3.5.3+)
3. Restful Countries API token

### API Setup

1. Obtain API token: [Restful Countries](https://restfulcountries.com/request-access-token)
2. Add token to `lib/utils/api_key.dart`:

```dart
const String authToken = 'your_api_key_here';
```

### Development Setup

1. Clone repository:
```bash
git clone https://github.com/Joshokelola/country_info_checker.git
cd country_info_checker
```

2. Install packages:
```bash
flutter pub get
```

3. Run application:
```bash
flutter run
```

### Production Deployment

Deploy to Appetize.io:

1. Build release APK:
```bash
flutter build apk --release
```

2. Upload to [Appetize.io](https://appetize.io)

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork repository
2. Create feature branch (`git checkout -b feature/Enhancement`)
3. Commit changes (`git commit -m 'Add Enhancement'`)
4. Push branch (`git push origin feature/Enhancement`)
5. Submit Pull Request

## 📄 License

MIT License - See [LICENSE](LICENSE) file

## 👤 Developer

**Joshua Okelola**
* Email: jayokelola341@gmail.com
* GitHub: [@Joshokelola](https://github.com/Joshokelola)
* Linkedin: [@Joshokelola](https://www.linkedin.com/in/joshua-okelola/)

---

Built with ❤️ using Flutter