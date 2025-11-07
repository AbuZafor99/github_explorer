# GitHub Explorer

A beautiful Flutter application for exploring GitHub repositories with clean architecture.

## Features

-   🔍 Search GitHub users by username
-   📱 Modern Material Design UI
-   🌙 Dark/Light theme support
-   📊 Repository statistics
-   🔄 List/Grid view toggle
-   📋 Detailed repository information
-   ⚡ Fast and responsive
-   🎨 Beautiful animations

## Screenshots

| Login Screen | Home Screen |
|:---:|:---:|
|(https://drive.google.com/uc?export=view&id=14Gvxxox09__iqKPkaZisympnaW0zyIS-) |(https://drive.google.com/uc?export=view&id=1JXerOp0TEPagYVIU68sULCSH20iQzJTr) |

## Architecture

This project follows Clean Architecture principles:

-   **Presentation Layer**: UI components, controllers, and state management
-   **Domain Layer**: Business logic, entities, and use cases
-   **Data Layer**: API integration and data models

## Tech Stack

-   **Flutter**: UI framework
-   **GetX**: State management and navigation
-   **Dio**: HTTP client for API calls
-   **GitHub REST API**: Data source

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the app

## Usage

1. Enter a GitHub username on the login screen
2. Explore the user's profile and repositories
3. Tap on any repository to view detailed information
4. Toggle between light and dark themes
5. Switch between list and grid views

## API Reference

This app uses the GitHub REST API:

-   User endpoint: `https://api.github.com/users/{userName}`
-   Repositories endpoint: `https://api.github.com/users/{userName}/repos`

## Contributing

Feel free to contribute to this project by submitting issues or pull requests.

## License

This project is open source and available under the [MIT License](LICENSE).
