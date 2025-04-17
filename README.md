# Maths&Me - Flutter GCSE Maths App

## How to Run

1. Install Flutter from https://flutter.dev/docs/get-started/install
2. Clone or unzip the project
3. Run:

   flutter pub get  
   flutter run

## Flutter Version

Tested with Flutter 3.10.5  
Dart 3.0.5

## API Keys

This app uses OpenAI GPT-3.5 APIs.
To run the app, replace the placeholder keys in:

  lib/secrets.dart

with your own OpenAI API keys:

  const openaiKey = 'your-key';
  const checkingKey = 'your-fine-tuned-key';

## Notes

- Works on Android and Web
- All data is stored locally in memory (no login)
- Teaching content is stored in teachingNotes.dart
- Main entry point: lib/main.dart
