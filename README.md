# Weather App

A streamlined weather application that provides a 5-day forecast based on the user's current location.

## Architecture & Conventions

### Architecture: MVVM + BLoC
The project follows the **MVVM (Model-View-ViewModel)** pattern, utilizing **BLoC (Business Logic Component)** for state management. This ensures a clean separation between the UI and business logic without the usual flutter_bloc library, but a custom implementation to show deep understanding.

- **Models**: Plain Dart objects representing the weather data (`Forecast`, `ForecastItem`, `ForecastMain`).
- **ViewModels (BLoC)**: Handles the logic for fetching data, managing loading/error states, and processing raw API data (filtering midday samples).
- **Views**: Flutter widgets that react to the state stream from the BLoC.
- **Repositories**: Acts as a data provider, abstracting the `ApiService` and the network layer.

### Conventions
- **Naming**: Follows the official Dart/Flutter style guide.
- **Modularity**: Code is split into folders (`network`, `services`, `mvvm`, `helpers`).
- **Statelessness**: Preference for `StatelessWidget` where possible, delegating state to the BLoC.
- **Testing**: A comprehensive, modular test suite covering unit and widget tests with zero external testing dependencies.

## Third-Party Dependencies

The project minimizes external dependencies to demonstrate native Flutter proficiency:

| Package | Purpose |
| :--- | :--- |
| `geolocator` | Accessing the device's GPS coordinates. |
| `geocoding` | Converting GPS coordinates into human-readable city names. |
| `flutter_lints` | Ensuring code quality and consistency with recommended rules. |

*Note: All mocks are custom-built stubs to minimize the dependency footprint.*

## How to Build

### Prerequisites
- Flutter SDK (Stable channel, version >= 3.7.0)
- Android Studio / VS Code with Flutter extensions
- Xcode (for iOS)
- An active internet connection for API calls
- Location services enabled on the device/emulator


### Steps
1. **Clone the repository**:
   ```bash
   git clone <repository_url>
   ```
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the project**:
   - For Android: Ensure an emulator or device is connected.
   ```bash
   flutter run
   ```
   - For iOS: Ensure CocoaPods are installed and configured.
   ```bash
   cd ios && pod install && cd ..
   flutter run
   ```

## Additional Considerations & "Nice-to-haves"

- **Midday Filtering**: The OpenWeather 5-day forecast API provides data in 3-hour intervals (40 samples). The BLoC implements logic to filter these down to a single "best match" for midday (12:00 PM) for each of the 5 days to provide a cleaner overview.
- **Custom ApiService**: Instead of using a heavyweight package like `dio`, the project uses a custom, generic `ApiService` built on top of Dart's native `HttpClient` to demonstrate low-level networking knowledge.
- **Layout Robustness**: The UI handles edge cases like unbounded list heights and safe area constraints to ensure a smooth experience across different screen sizes.