# holbegram

Holbegram is a Flutter app that recreates a social photo-sharing flow with
authentication, profiles, posts, and basic navigation.

## Features

- Login and sign-up flows
- Profile image upload (Cloudinary)
- Post creation and feed display (Firestore)
- Search grid for posts
- Favorites saved locally during a session

## Requirements

- Flutter SDK
- Firebase project with Auth + Firestore enabled
- Cloudinary account with an unsigned upload preset

## Setup

1. Install dependencies:

   ```bash
   flutter pub get
   ```

2. Configure Firebase for web:

   ```bash
   flutterfire configure
   ```

3. Update Cloudinary settings in `lib/screens/auth/methods/user_storage.dart`:
   - `cloudinaryUrl`
   - `cloudinaryPreset`

## Run

```bash
flutter run -d chrome
```

## Notes

- Enable Email/Password in Firebase Authentication.
- If you see CORS errors for external images on web, replace them with assets.
