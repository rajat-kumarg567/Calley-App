# Calley – Automatic Call Dialer (Flutter)

Mobile app for Calley. Users register, verify their number with a WhatsApp OTP,
log in, and view their calling dashboard.

## Features

| Screen | Status |
|---|---|
| Choose language | UI done (selection is not saved yet) |
| Register | Real API |
| WhatsApp OTP verification | Real API (Send OTP + Verify) |
| Login | Real API |
| Dashboard (empty state + chart) | Real API (chart status counts pending – see Known limitations) |
| Start Calling Now → Calling Lists sheet | Real API |
| Getting Started (video) | UI done |
| Drawer, Settings | UI done (most drawer items say "Coming soon") |

## Tech stack

- Flutter / Dart
- State management: **Provider** (`ChangeNotifier` controllers)
- Networking: **dio**
- Fonts: **google_fonts** (Inter)
- Icons: Material icons + **font_awesome_flutter** (WhatsApp)

## Getting started

```bash
flutter pub get
flutter run
```

Requirements:
- `INTERNET` permission in `android/app/src/main/AndroidManifest.xml`
  (needed for release builds):
  ```xml
  <uses-permission android:name="android.permission.INTERNET"/>
  ```
- Images in `assets/images/` (the app shows a fallback if one is missing):

  | File | Used for |
    |---|---|
  | `calley_logo.png` | Logo on Login / Register / OTP |
  | `avatar.png` | User avatar |
  | `load_numbers.png` | Illustration on the empty dashboard |
  | `video_thumbnail.png` | Getting Started video thumbnail |
  | `whatsapp.png` | WhatsApp button / field icon |

- `pubspec.yaml` must declare the folder:
  ```yaml
  flutter:
    assets:
      - assets/images/
  ```

After adding or renaming an image, **stop and run the app again** (hot reload does
not load new assets).

## Project structure

Feature-first. Each feature keeps its own data, models, controllers and UI.

```
lib/
├── main.dart, app.dart              # entry point, providers, theme, routes
├── core/
│   ├── constants/                   # colors, asset paths, app constants
│   ├── network/api_client.dart      # dio client (base URL, errors, logging)
│   ├── theme/                       # text styles, theme
│   ├── routes/app_routes.dart       # named routes
│   └── utils/                       # validators, snackbar helper
├── shared/widgets/                  # reusable widgets
│   ├── app_text_field, app_button, auth_scaffold, auth_footer_text
│   ├── navy_header_card, user_banner, start_calling_bar
│   └── whatsapp_button, arrow_box_icon, app_avatar, calley_logo,
│       india_flag, safe_asset_image
└── features/
    ├── auth/        # login, register, OTP
    ├── language/    # choose language
    ├── dashboard/   # dashboard, empty state, getting started
    ├── home/        # bottom nav shell, drawer, app bar
    └── settings/    # settings screen, calling lists sheet

each feature:  data/ (repository)  ·  models/  ·  controllers/  ·  presentation/
```

Flow of data: `Screen → Controller → Repository → ApiClient → API`.
To change an API, only the repository (and its model) needs editing.

## API

Base URL: `https://mock-api.getcalley.com/api/service`
(configured in `lib/core/network/api_client.dart`)

All endpoints are **GET** with query parameters, as per the Postman docs.

| Purpose | Endpoint | Parameters |
|---|---|---|
| Register | `/RegistrationV5` | `name`, `emailId`, `password`, `mobile`, `countrycode`, `countryname`, `location` |
| Login | `/userloginV3` | `emailid`, `password` |
| Send OTP | `/SendOTP` | `userid`, `Device` |
| Verify OTP | `/UpdateUserVerifiedStatus` | `userid`, `userMobile` |
| Get call lists | `/GetListsV4` | `userid` |
| Get list details | `/GetListDataV7` | `userid`, `listid` |

Notes:
- `location` (Register) and `userMobile` (Verify OTP) carry the **platform**
  (`android` / `ios`), not a place or a phone number.
- Login returns `StatusCode: 1` on success and `StatusCode: 0` on failure.
  The `userid` from Login is required by every later call.
- Send OTP returns the OTP in the response. The app compares it locally and then
  calls Verify OTP to mark the account verified.
- "Get list details" with no contacts returns `StatusCode: 2` ("No Records").

### App flow

```
Register → Login → Send OTP → Verify OTP → Dashboard
                                              │
                          Start Calling Now ──┘
                                │
                      Calling Lists sheet (GetListsV4)
                                │  tap a list
                      GetListDataV7 → Dashboard
```

The "Load number to call" screen shows until a list is chosen. After a list is
chosen the dashboard shows its counts, even when they are all 0.

## Known limitations / TODO

- **Chart counts:** every contact is counted as *pending*. The field that marks a
  contact as done / scheduled is not known yet (needs a real `GetListDataV7`
  response with contacts).
- **Login is not remembered:** no token/session is stored, so the app asks for
  login on every launch.
- **Unverified users:** login does not check `IsVerified` yet.
- Placeholder tabs: Contacts, Calling, Call Logs, Schedule.
- Drawer items without an API/design: Sync Data, Gamification, Send Logs, Help,
  Cancel Subscription, About Us, Privacy Policy, Share App.
- Forgot Password and Change Password have no API yet.
- The WhatsApp field on Register is not sent (the Register API has no such field).
- `countryname` is fixed to `India` and the platform to `android`.
- Language selection is not persisted or applied.
- **Security:** Send OTP returns the OTP to the app. Verification should be done on
  the server.

## Before a release build

1. Remove the `LogInterceptor(...)` line in `api_client.dart` (it prints
   passwords and responses).
2. Remove the `debugPrint(...)` lines in the repositories.
3. Confirm the `INTERNET` permission is in `AndroidManifest.xml`.
4. Test with `flutter run --release` or `flutter build apk`.

## Troubleshooting

| Problem | Likely cause |
|---|---|
| `Undefined name 'main'` on `AppRoutes.main` | A wrong auto-import (`dart:nativewrappers/...`) was added by the IDE. Delete that import line. |
| `TextTheme can't be assigned to TextTheme?` | `google_fonts ^9` uses a different Material package. Use `google_fonts: ^8.0.0`. |
| Image shows a fallback icon | File name or folder does not match, or the app was only hot reloaded. |
| `HandshakeException … Hostname mismatch` | Server SSL certificate problem (backend issue). |
| `504 Gateway Timeout` | The mock server is down or asleep (backend issue). |
