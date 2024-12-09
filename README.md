# Pantry CRUD App

This is a Flutter-based mobile application designed for managing a personal pantry inventory. It allows users to add, edit, delete, and view a list of products, along with a log of their actions. The app also includes basic user authentication with login and signup functionality.

## Design and Functionality

The app is built using a modular architecture, with separate components for different screens and functionalities. It uses `SharedPreferences` for local data storage and `http` for communication with a remote API.

### Main Components

1. **Authentication (`lib/auth_service.dart`)**:
    -   Handles user authentication using a remote API (`https://flutter-api-sd0r.onrender.com`).
    -   Provides `login` and `signup` methods.
    -   Uses a hardcoded bearer token for authorization.
    -   Stores user data and JWT token in `SharedPreferences` upon successful login.

2. **Welcome Screen (`lib/screens/welcome_screen.dart`)**:
    -   The initial screen shown to the user.
    -   Displays a welcome message, a profile picture, and buttons to navigate to the "Add Items" and "Login" screens.
    -   Checks login status using `SharedPreferences`.

3. **Login Screen (`lib/screens/login_screen.dart`)**:
    -   Allows users to log in using their username and password.
    -   Uses `AuthService` to authenticate the user.
    -   Navigates to the `WelcomeScreen` upon successful login.
    -   Provides a link to the `SignUpScreen`.

4. **Signup Screen (`lib/screens/signup_screen.dart`)**:
    -   Allows users to create a new account.
    -   Sends a POST request to the API to register the user.

5. **Product Entry Screen (`lib/screens/product_entry_screen.dart`)**:
    -   Allows users to add new products or edit existing ones.
    -   Stores product details (ID, name, quantity) in `SharedPreferences`.
    -   Logs product additions and edits.

6. **Product List Screen (`lib/screens/product_list_screen.dart`)**:
    -   Displays the list of products stored in `SharedPreferences`.
    -   Allows users to edit or delete products.
    -   Provides an option to view logs.

7. **Log Screen (`lib/screens/log_screen.dart`)**:
    -   Displays a list of logs stored in `SharedPreferences`.
    -   Shows the history of product additions, edits, and deletions.

8. **Bottom Navigation Menu (`lib/widgets/bottom_navigation_menu.dart`)**:
    -   Provides navigation between the `WelcomeScreen`, `ProductListScreen`, and `ProductEntryScreen`.

### App Structure

-   `lib/main.dart`: Entry point of the app. Sets up the theme and uses `BottomNavigationMenu` as the home screen.
-   `lib/auth_service.dart`: Handles authentication logic.
-   `lib/screens/`: Contains the UI components for different screens.
-   `lib/widgets/`: Contains reusable UI elements.

### Dependencies

-   `flutter/material.dart`: Flutter's Material Design library.
-   `http`: For making HTTP requests to the API.
-   `shared_preferences`: For local data storage.

## Potential Improvements

-   Replace the hardcoded bearer token with a more secure authentication mechanism.
-   Implement error handling for API requests and display user-friendly error messages.
-   Add more robust input validation.
-   Consider using a state management solution (e.g., Provider, BLoC) for more complex state management.
-   Add unit and widget tests to ensure code quality.

## Flutter Commands

### Install Dependencies

To install the project's dependencies, run the following command in the terminal:

```bash
flutter pub get
```

### Run the App

To run the app in debug mode, use the following command:

```bash
flutter run
```

### Build the App

To build the app for release, use the following commands for the respective platforms:

**Android:**

```bash
flutter build apk
```

**iOS:**

```bash
flutter build ios
```

**Web:**

```bash
flutter build web
```

**Linux:**

```bash
flutter build linux
```

**macOS:**

```bash
flutter build macos
```

**Windows:**

```bash
flutter build windows
