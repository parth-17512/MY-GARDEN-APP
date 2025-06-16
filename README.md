# My Garden App

A Flutter application that helps users manage their plant collection with Firebase integration.

## Demo Video
🎥 [Watch the App Demo]
https://drive.google.com/file/d/1egyolRqYko8MRFZWg2u7y5ht4e41tAdb/view?usp=sharing

The video demonstrates:
- Complete authentication flow (Sign-up, Login, Logout)
- Adding a new plant to the collection 
- Deleting existing plants
- Real-time updates in the UI

## Features

- 🌱 Track your plants with name and acquisition date
- 🔐 User authentication with Firebase
- 💾 Real-time data synchronization
- ☁️ Cloud Function for automatic timestamp creation
- 📱 Clean and intuitive UI

## Setup Instructions

### Prerequisites
- Flutter SDK
- Firebase account
- VS Code or Android Studio

### Firebase Setup
1. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com)
2. Enable Authentication (Email/Password)
3. Enable Cloud Firestore
4. Upgrade to Blaze (pay-as-you-go) plan for Cloud Functions
5. Install Firebase CLI:
```powershell
npm install -g firebase-tools
```

### Cloud Function Setup
The project includes a Cloud Function that automatically adds a creation timestamp when a new plant is added:

```typescript
// functions/src/index.ts
import * as functions from "firebase-functions/v2";
import * as admin from "firebase-admin";

admin.initializeApp();

export const addCreatedAtTimestamp = functions.firestore
  .onDocumentCreated("plants/{plantId}", async (event) => {
    const snapshot = event.data;
    if (!snapshot) return;
    const createdAt = admin.firestore.FieldValue.serverTimestamp();
    await snapshot.ref.update({createdAt});
  });
```

### Project Setup
1. Clone the repository
2. Install dependencies:
```bash
flutter pub get
```
3. Set up Firebase:
```bash
flutter pub add firebase_core
flutter pub add cloud_firestore
flutter pub add firebase_auth
```
4. Run the app:
```bash
flutter run
```

## Architecture & Design Choices

### State Management
The project uses **Provider** for state management because:
- Lightweight and official Flutter solution
- Perfect for medium-sized applications
- Easy to understand and maintain
- Great integration with Firebase streams

### Project Structure
```
lib/
├── models/         # Data models
├── providers/      # State management
├── screens/        # UI screens
├── services/       # Firebase services
└── widgets/        # Reusable widgets
```

## Challenges & Solutions

1. **Cloud Function Setup**
   - Challenge: Initial setup of Cloud Functions with TypeScript
   - Solution: Created proper TypeScript configuration and handled version compatibility

2. **Real-time Updates**
   - Challenge: Implementing real-time plant updates
   - Solution: Utilized Firestore streams with Provider for reactive UI updates

3. **Authentication Flow**
   - Challenge: Smooth authentication state management
   - Solution: Implemented AuthWrapper for seamless navigation

## Assumptions

1. Users will primarily use the app for personal plant collections
2. Internet connectivity is required for app functionality
3. Basic plant information (name and date) is sufficient for MVP
4. Users prefer a simple, intuitive interface

## Future Improvements

- Add plant images
- Implement plant care reminders
- Add plant categories
- Offline support
- Social sharing features

## License

MIT License - feel free to use this project for learning and development.

## Credits

Developed by Parth Singh as part of Firebase/Flutter learning journey.
