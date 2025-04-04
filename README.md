# *Password Manager - Secure Password Manager*

A secure and user-friendly password manager application built with Flutter that helps users store and manage their passwords safely in offline mode alone.
---
## *📂 Project Structure*
```
password_manager/
├── lib/
│   ├── Database/
│   │   └── database_helper.dart
│   ├── Models/
│   │   └── password_model.dart
│   ├── Pages/
│   │   ├── AddPasswordPage.dart
│   │   ├── GeneratorPage.dart
│   │   ├── HomePage.dart
│   │   ├── LoginPage.dart
│   │   ├── RegisterPage.dart
│   │   ├── SettingsPage.dart
│   │   ├── VaultPage.dart
│   │   └── ViewPasswordPage.dart
│   └── main.dart
├── assets/
│   └── images/
├── android/
├── ios/
└── pubspec.yaml
```
---
## *🚀 Features*

- **Secure Authentication**
  - Biometric authentication support
  - Master password protection
  - Device PIN/Pattern lock integration

- **Password Management**
  - Securely store website credentials
  - View and edit saved passwords
  - Search functionality for quick access
  - Delete unwanted entries

- **Password Generator**
  - Generate strong passwords
  - Customizable password criteria
    - Length
    - Uppercase letters
    - Lowercase letters
    - Numbers
    - Special characters
  - Password strength indicator
  - Copy to clipboard functionality

- **User Interface**
  - Clean and intuitive design
  - Bottom navigation bar
  - Password strength visualization
  - Easy-to-use forms
---
## *🛠️ Tech Stack*

- **Framework**: Flutter
- **Language**: Dart
- **Database**: SQLite (sqflite)
- **State Management**: setState
- **Authentication**: local_auth
- **Storage**: shared_preferences
- **Navigation**: persistent_bottom_nav_bar
- **Form Validation**: form_field_validator
---
## *💻 Installation and Setup*

1. **Prerequisites**
   ```bash
   flutter --version
   # Ensure Flutter is installed and up to date
   ```

2. **Clone the Repository**
   ```bash
   git clone https://github.com/Saisandeepsangeetham/Password-Manager.git
   cd Password-Manager
   ```

3. **Install Dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the Application**
   ```bash
   flutter run
   ```

## *Development Setup*

1. **Generate Database Models**
   ```bash
   flutter packages pub run build_runner build
   ```

2. **Update App Icon**
   ```bash
   flutter pub run flutter_launcher_icons:main
   ```

3. **Update Splash Screen**
   ```bash
   flutter pub run flutter_native_splash:create
   ```
---
## *📷 Screenshots*

### Authentication
![Login Screen](assets/Readme%20Assets/LoginPage.png)
![Register Screen](assets/Readme%20Assets/registerPage.png)

### Password Vault
![Vault Screen](assets/Readme%20Assets/ValutPage.png)
![Search Functionality](assets/Readme%20Assets/searchFunctionality.png)

### Password Management
![Add Password](assets/Readme%20Assets/addPassword_page.png)
![View Password](assets/Readme%20Assets/viewPassword_page.png)

### Password Generator
![Password Generator](assets/Readme%20Assets/passwordGenerator.png)

### Settings
![Settings Screen](assets/Readme%20Assets/settingPage.png)

## *Security Features*

- Encrypted database storage
- Biometric authentication
- Auto-lock functionality
- Secure password generation
- Clipboard clearing
- Screen security (no screenshots)
---
## *🤝 Contributing*

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request
---
## License

This project is licensed under the MIT License.
---
## *📞 Contact*
For any queries, feel free to reach out:
- Email: sandeep.sangeetham@gmail.com
- GitHub: [Saisandeepsangeetham](https://github.com/Saisandeepsangeetham)
- LinkedIn: [Saisandeep Sangeetham](https://linkedin.com/in/saisandeep-sangeetham)
