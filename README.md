# FOCUS — fresh Flutter repository

This is a **new GitHub-ready Flutter foundation** for the FOCUS app. It does not reuse code or assets from any earlier social app.

## Build Android in GitHub Actions
1. Create a new GitHub repository named `focus`.
2. Upload the contents of this ZIP to the repository root (not the ZIP file itself).
3. Open **Actions** and run **FOCUS Android Build**, or push to `main`.
4. Download the `FOCUS-Android-Builds` artifact from the completed workflow.

## Important status
This package is a development foundation, **not a complete social network** and not ready for public release. Feed cards currently use local placeholder content. Authentication/OTP, database, secure private-account enforcement, real photo/video upload, stories/reels, chat, push notifications, audio/video calling, admin tools, and moderation are not connected yet.

Before beta testing with real users, configure a backend and storage, enforce authorization on the server, add platform signing, and test on real Android and iPhone devices. iOS TestFlight additionally requires an Apple Developer account and App Store Connect setup.

## Brand assets
The approved FOCUS logo image was not available as a file in the request that generated this ZIP. The current UI uses a temporary gradient mark. Replace it with the exact approved logo in `assets/` once the image is supplied; do not redraw or alter the approved logo.

## iOS
The workflow builds Android artifacts only. iOS builds must run on macOS and require Apple signing / TestFlight configuration.
