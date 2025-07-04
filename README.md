
# Plant Vaidya - Flutter Edition

This is a Flutter application that acts as an AI-powered plant care assistant. It allows users to:

1.  Upload an image of a plant (from gallery or camera).
2.  Optionally provide a description.
3.  Choose to either:
    *   Analyze the plant for diseases.
    *   Get general information and care tips about the plant.
4.  View analysis history.

## Features

*   **Plant Disease Analysis:** Uses AI to detect potential diseases from an image and description. Provides suggested solutions, prioritizing home-based remedies.
*   **Plant Information:** Provides details like common name, Latin name, description, care tips, and fun facts about a plant.
*   **Image Upload:** Supports picking images from the gallery or taking a new photo with the camera.
*   **History:** Stores past analyses and information requests locally for easy review.
*   **Cross-Platform:** Built with Flutter for Android, iOS, Web, and Desktop (macOS, Windows, Linux).

## Getting Started

This project is a Flutter application.

### Prerequisites

*   Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
*   An editor like Android Studio (with Flutter plugin) or VS Code (with Dart and Flutter extensions).
*   A Google AI API Key for Gemini:
    *   You can obtain one from [Google AI Studio](https://aistudio.google.com/app/apikey).
    *   Create a `.env` file in the root of your project (e.g., `flutter_app/.env` if you haven't moved the files yet, or just `.env` after moving files to the root) and add your API key:
        ```
        GEMINI_API_KEY=YOUR_ACTUAL_API_KEY_HERE
        ```
    *   **Security Note:** Ensure the `.env` file is listed in your `.gitignore` file to prevent your API key from being committed to version control.

### Setup

1.  **Clone the repository (if applicable).**
2.  **Navigate to the project directory:**
    ```bash
    cd path/to/plant_vaidya
    ```
3.  **Get dependencies:**
    ```bash
    flutter pub get
    ```
4.  **Configure API Key:**
    Ensure you have created the `.env` file as described in the Prerequisites section.

5.  **Run the app:**
    *   Ensure you have a device connected or an emulator/simulator running.
    *   For Android: `flutter run`
    *   For iOS: `flutter run`
    *   For Web: `flutter run -d chrome`
    *   For Desktop (e.g., macOS): `flutter run -d macos` (ensure desktop support is enabled: `flutter config --enable-macos-desktop`)

## Project Structure

*   `lib/`: Contains all the Dart code for the Flutter application.
    *   `main.dart`: The entry point of the application.
    *   `models/`: Data model classes (e.g., `PlantInformation`, `HistoryEntry`, `AnalysisResultData`).
    *   `providers/`: State management logic (e.g., `AppStateProvider` using `ChangeNotifier`).
    *   `screens/`: Top-level UI screens (e.g., `HomeScreen`, `HistoryScreen`).
    *   `services/`: Business logic and external communication (e.g., `ApiService` for AI interactions, `HistoryService` for local storage).
    *   `utils/`: Utility functions, constants, theme configuration, and helper classes (e.g., `ImagePickerUtils`).
    *   `widgets/`: Reusable UI components (e.g., forms, result displays, list items).
*   `assets/`: Static assets like images (e.g., `logo.png`) and environment files (`.env`).
*   `android/`, `ios/`, `web/`, `linux/`, `macos/`, `windows/`: Platform-specific project files generated by Flutter.
*   `pubspec.yaml`: Project metadata and dependencies.

## How it Works (Flutter App)

1.  **UI (Flutter Widgets):** The user interacts with the Flutter UI (e.g., `PlantAnalysisFormWidget`) to upload an image, add a description, and select an action.
2.  **State Management (`provider` package):** `AppStateProvider` manages the application's state, such as loading status, API results, and history.
3.  **API Service (`ApiService`):**
    *   When an action is triggered, the `ApiService` is called.
    *   This service uses the `google_generative_ai` package to directly interact with the Google Gemini API.
    *   Image data is converted to a base64 string and then to `Uint8List` for API transmission.
4.  **AI Processing (Google Gemini API):**
    *   The Gemini API processes the input (image, text) and returns a JSON response based on the prompts defined in `ApiService`.
5.  **Display Results:** The Flutter app receives the response, parses it into Dart models (e.g., `AnalysisResultData`, `PlantInformation`), updates the app state via `AppStateProvider`, and displays the results using widgets like `AnalysisResultWidget` or `PlantInformationWidget`.
6.  **History (`HistoryService`):** Analysis results and information requests are saved locally using `shared_preferences` and can be viewed on the `HistoryScreen` via `HistoryListWidget`.

## Further Development Ideas

*   **Refine Prompts:** Iterate on the prompts sent to the Gemini API for better accuracy and more detailed responses.
*   **Offline Support:** Cache plant information or allow for offline analysis of previously identified issues (would require on-device models or more complex caching).
*   **User Accounts & Cloud Sync:** Allow users to create accounts and sync their history across devices (e.g., using Firebase Firestore).
*   **Advanced UI/UX:** Enhance animations, create custom painters for overlays on images, etc.
*   **Localization:** Support multiple languages.
*   **Community Features:** Allow users to share findings or tips.

This Flutter project provides a foundation for a comprehensive plant care assistant.
