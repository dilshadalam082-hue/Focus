# FOCUS — Flutter + Supabase project

This is a fuller starter project, not a finished/production-ready social network.

## Features in this project
- Flutter app structure and bottom navigation
- Supabase email/password authentication (requires credentials)
- Profile read/update structure
- Feed: query posts from Supabase
- Create post: media selection and upload structure
- Likes data model/query structure
- Reels screen structure
- Messages/notifications/profile screens
- Supabase SQL schema and storage bucket setup
- Android APK build workflow

## Setup
1. Install Flutter stable and use this project.
2. Create a Supabase project.
3. Run `supabase/schema.sql` in Supabase SQL Editor.
4. Create storage buckets `media` and `avatars` (public for starter; adjust policies before production).
5. Create `lib/config.dart` using the example file and your Supabase URL/key.
6. Run `flutter pub get`, then `flutter run`.

## Configure
Copy `lib/config.example.dart` to `lib/config.dart` and fill in the Supabase project URL and anon key. Do not commit secrets.

## Build
`flutter build apk --release`

Real-time chat, push notifications, audio/video calling, moderation, abuse reporting, and robust privacy/security rules require additional implementation and provider setup. They are not falsely marked as working in this starter.
