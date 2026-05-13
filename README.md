# 📝 Flutter Task Manager App

A simple and clean Task Manager mobile application built using Flutter.  
This app demonstrates state management using Provider and local persistence using SharedPreferences.

---

## 🚀 Features

- ➕ Add new tasks
- ✏️ Edit existing tasks
- 🗑️ Delete tasks (swipe to dismiss)
- ✅ Mark tasks as complete/incomplete
- 💾 Persistent storage using SharedPreferences
- 🎨 Animated UI updates using AnimatedContainer
- ⏳ Splash screen with auto navigation
- 🔄 Real-time state updates using Provider

---

## 🛠️ Tech Stack

- Flutter
- Dart
- Provider (State Management)
- SharedPreferences (Local Storage)

---

## 📱 App Flow

Splash Screen → Home Screen → Task Management

---

## 📂 Project Structure

lib/
│
├── main.dart
├── task_enum.dart
│
├── provider/
│   └── task_provider.dart
│
├── screens/
│   ├── splash_screen.dart
│   └── home_screen.dart
│
└── components/
    └── task_dialogue.dart

---

## ⚙️ State Management

This app uses Provider for state management.

TaskProvider handles:
- Task list storage
- Add task
- Edit task
- Delete task
- Toggle completion
- Save & load from local storage

---

## 💾 Local Storage (Persistence)

Tasks are stored locally using SharedPreferences.

Tasks are saved as JSON:

jsonEncode(tasks);

Loaded back as:

jsonDecode(taskJson);

This ensures data remains after app restart.

---

## 🧠 Core Functionalities

### ➕ Add Task
- Input from dialog
- Stored with isComplete = false
- Saved locally

### ✏️ Edit Task
- Opens dialog with current value
- Updates task title
- Saves changes

### 🗑️ Delete Task
- Swipe left/right (Dismissible)
- Removes task permanently
- Updates storage

### ✅ Toggle Task
- Checkbox toggles completion
- Completed tasks show:
  - Green background
  - Strikethrough text
- Incomplete tasks show:
  - Orange background

---

## ⏳ Splash Screen

- Shows splash image for 3 seconds
- Automatically navigates to Home Screen

---

## 🎨 UI Features

- AnimatedContainer for smooth updates
- Swipe-to-delete interaction
- Clean card-style task UI
- Responsive layout using Expanded widgets

---

## 📦 Dependencies

Add in pubspec.yaml:

dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.5+1
  shared_preferences: ^2.5.5


## 📌 Key Concepts Used

- Provider state management
- Local storage with SharedPreferences
- Dialog-based input handling
- ListView.builder for dynamic UI
- Dismissible swipe actions
- AnimatedContainer for UI transitions


## 👨‍💻 Author

Faraz Sarwar

---

## 📜 License

This project is open-source and free to use for learning purposes.