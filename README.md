# Pokede Field Assistant

A Flutter application to explore Pokémon data, featuring search, filtering, and bookmarking capabilities.

---

## Setup & Run Instructions

1. **Install Flutter**: Ensure Flutter SDK is installed. Follow the [Flutter installation guide](https://docs.flutter.dev/get-started/install).
2. **Clone the Repository**: 
   ```bash
   git clone <repository-url>
   cd pokede_field_assistant
   ```
3. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run the App**:
   ```bash
   flutter run
   ```

---

## Architecture Overview

- **UI Layer**: Built with Flutter's `Widget` system, using custom widgets like `ListBuilder`, `ElementViewer`, and `CustomFutureBuilder` for modularity.
- **State Management**: Lightweight state is managed using `StatefulWidget` and helper classes like `SwitchViewHelper` and `BuilderHelper`.
- **Data Layer**: 
  - Pokémon data is fetched from the [PokeAPI](https://pokeapi.co/).
  - Weather-based Pokémon filtering is powered by the [Open-Meteo API](https://open-meteo.com/).
  - Shared preferences are used for local storage (e.g., bookmarks).
- **Platform-Specific Code**: Includes Linux and Android-specific configurations for seamless cross-platform support.

---

## State Management Rationale

The app uses `StatefulWidget` for simplicity and direct control over UI updates. This approach is sufficient for the current scale of the app. For larger or more complex apps, a state management solution like `Provider` or `Riverpod` could be considered.

---

## Notes on Tests

- **Current Status**: No tests are implemented yet.
- **Future Plans**:
  - Unit tests for helper classes (e.g., `BuilderHelper`, `Pokemon`).
  - Widget tests for UI components like `ListBuilder` and `ElementViewer`.
  - Integration tests for end-to-end functionality.

---

## Things to Improve with More Time

1. **Testing**: Add comprehensive unit, widget, and integration tests.
2. **Error Handling**: Improve error messages and fallback UI for API failures.
3. **Performance**: Optimize API calls and caching for smoother user experience.
4. **UI/UX Enhancements**: Add animations, better theming, and accessibility features.
5. **State Management**: Introduce a more scalable solution like `Riverpod` for better separation of concerns.
6. **Documentation**: Add inline code comments and API documentation for better maintainability.
7. **Offline Mode**: Implement offline support by caching Pokémon data locally for use without an internet connection.
8. **Search Optimization**: Enhance the search functionality with fuzzy matching and advanced filtering options.
9. **Localization**: Add support for multiple languages to make the app accessible to a global audience.
10. **Testing Automation**: Set up CI/CD pipelines to automate testing and deployment processes.
11. **Modularization**: Refactor the codebase to improve modularity and reusability of components.

---

Feel free to contribute to the project by submitting issues or pull requests!