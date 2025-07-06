#  Firebase Notes App (Flutter)

A simple notes application built with Flutter and Firebase that supports full **authentication** and **CRUD operations** using **Bloc (Cubit)** for state management and a clean architecture pattern.

---

##  Features

-  Firebase Authentication (Email/Password)
-  Create, Read, Update, Delete Notes
-  Cloud Firestore Integration
-  Bloc/Cubit for state management
-  SnackBars for all feedback
-  Clean folder structure and separation of concerns

---

##  Screens

- Login / Signup screen with validation
- Notes list with empty-state message
- Add / edit / delete notes with confirmation dialog
- Logout functionality

---

##  Architecture Overview

```
lib/
├── cubit/            
│   ├── auth_cubit.dart
│   └── notes_cubit.dart
├── models/           
│   └── note_model.dart
├── repository/       
│   └── note_repository.dart
├── screens/          
│   ├── login_screen.dart
│   └── notes_screen.dart
├── widgets/          
│   └── note_tile.dart
└── main.dart
└── app.dart         
```

---

##  Setup Instructions

### Prerequisites
- Flutter 3.x installed
- Firebase project created
- Android/iOS emulator or device

### Firebase Setup

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Enable **Email/Password** authentication
3. Create a **Cloud Firestore** database
4. Add an Android app using your package name (check `android/app/src/main/AndroidManifest.xml`)
5. Download `google-services.json` and place it in `android/app/`
6. Run the following:

```bash
flutter pub get
flutterfire configure
flutter run
```

---

##  Dart Analyzer Report

```bash
flutter analyze
```

Should report **no issues** if project is clean.

---

##  Demo Video

https://www.youtube.com/watch?v=gRfcDTtX_Zs 


---

## Author

Marie Elyse UYIRINGIYE

---

##  License

MIT — Free to use for educational purposes.
