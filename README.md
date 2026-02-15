![mybini-gif](mybini-gif.gif)

# MyBini

A Flutter package that provides a complete MVC (Model-View-Controller) architecture framework with Firebase integration, authentication, and responsive design utilities.

## Features

MyBini offers a comprehensive MVC framework for Flutter applications with the following key features:

### MVC Architecture

- **Model**: Abstract Model class with built-in Firebase Firestore and Realtime Database integration
- **View**: Abstract View classes for both StatelessWidget and StatefulWidget with Firebase data binding
- **Controller**: Abstract Controller class for managing business logic and user interactions

### Firebase Integration

- **Firestore Operations**: Built-in methods for reading, writing, and managing Firestore collections
- **Realtime Database**: Complete CRUD operations for Firebase Realtime Database
- **Authentication**: Google Sign-in integration ready to use

### Responsive Design Utilities

- **Size Helpers**: Easy-to-use screen width and height utilities
- **Breakpoint System**: Bootstrap-like breakpoints (XS, SM, MD, LG, XL, XXL)
- **Orientation Detection**: Portrait and landscape detection functions

### Core Components

- **Abstract Model**: Extendable model class with table-like data structure
- **Firebase Integration**: Seamless Firestore and Realtime Database operations
- **View Components**: Pre-configured view classes with Firebase data support
- **Authentication**: Google Sign-in implementation
- **Helper Functions**: Screen size and breakpoint utilities

## Getting started

### Prerequisites

- Flutter SDK
- Firebase project setup
- Cloud Firestore enabled
- GoRoute for Routing
- Firebase Realtime Database enabled (optional)
- Google Sign-in configured (for auth features)

### Installation

This package is not published yet, i will give installation guide after i publish this package soon :3
~ Felix

## Usage

### Basic MVC Implementation

```dart
import 'package:mybini/mybini.dart';

// Model Example
class UserModel extends Model {
  @override
  List<String> get tableKeys => ['name', 'email', 'age'];

  @override
  String get firestorePath => 'users';

  @override
  String get realtimePath => 'users';
}

// View Example
class UserView extends View {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: Container(
        width: width(context),
        height: height(context),
        child: Column(
          children: [
            if (isMD(context))
              Text('Medium screen detected'),
            // Your UI components
          ],
        ),
      ),
    );
  }
}

// Controller Example
class UserController extends Controller {
  const UserController({super.key});

  @override
  Widget build(BuildContext context) {
    return UserView();
  }
}
```

### Firebase Operations

```dart
// Create and use a model
UserModel user = UserModel();
user.setData(['John Doe', 'john@example.com', 25]);

// Firestore operations
await user.firestoreWrite();
QuerySnapshot data = await user.firestoreRead();

// Realtime Database operations
await user.realtimeWrite();
DatabaseEvent event = await user.realtimeRead();
```

### Responsive Design

```dart
Widget build(BuildContext context) {
  return Container(
    width: width(context, scale: 0.8), // 80% of screen width
    child: Column(
      children: [
        if (isXS(context)) Text('Extra Small Screen'),
        if (isSM(context)) Text('Small Screen'),
        if (isMD(context)) Text('Medium Screen'),
        if (isLG(context)) Text('Large Screen'),
        if (isXL(context)) Text('Extra Large Screen'),
        if (isPortrait(context)) Text('Portrait Mode'),
      ],
    ),
  );
}
```

### Authentication

```dart
import 'package:mybini/mybini.dart';

// Google Sign-in
try {
  UserCredential userCredential = await signInWithGoogle();
  print('Signed in: ${userCredential.user?.displayName}');
} catch (e) {
  print('Sign-in error: $e');
}
```

## Additional information

This package provides a solid foundation for Flutter applications using MVC architecture with Firebase integration. It's designed to speed up development by providing pre-built components and utilities commonly needed in Flutter apps.

### Package Structure

- `lib/model.dart` - Abstract Model class with Firebase integration
- `lib/view.dart` - Abstract View classes for UI components
- `lib/controller.dart` - Abstract Controller class for business logic
- `lib/auth.dart` - Authentication utilities (Google Sign-in)
- `lib/helper/size.dart` - Screen size utility functions
- `lib/helper/breakpoint.dart` - Responsive breakpoint functions

For more examples and detailed documentation, visit our [GitHub repository](https://github.com/felix43425021-RE-Polines/mybini).

### Contributing

We welcome contributions! Please feel free to submit issues, feature requests, or pull requests on our GitHub repository.

### Support

If you encounter any issues or have questions, please file an issue on our GitHub repository or reach out to the maintainers.
