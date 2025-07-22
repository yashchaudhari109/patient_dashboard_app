# Patient Dashboard Flutter App

A cross-platform mobile app for patients to view their dashboard, medication status, and shipment history. This project was built to fulfill the requirements of a take-home assignment, focusing on clean architecture, modern state management, and a high-quality user experience.

## Features

-   **Authentication**: Secure login screen using mock credentials (`test@test.com` / `password`).
-   **Session Persistence**: Keeps the user logged in across app restarts using `shared_preferences`.
-   **Dashboard**: A clear and concise dashboard displaying key patient information:
    -   Full Name & Patient ID
    -   Current Plan
    -   Next Delivery Date
    -   Remaining Medication
    -   Status Summary (Active/Inactive, Billing OK)
-   **Shipment History**: An efficient, scrollable list of past shipments rendered with `ListView.builder`.
-   **Custom Animations**: Subtle fade-in and slide animations on the shipment history list to enhance the UI.
-   **Navigation**: Implemented using `go_router` with a persistent bottom navigation bar for seamless screen transitions.

## Getting Started

### Prerequisites

-   Flutter SDK (version 3.0 or higher recommended).
-   A code editor like VS Code or Android Studio with the Flutter plugin.

### Setup & Run

1.  **Clone the repository:**
    ```sh
    git clone <your-repository-url>
    cd <your-project-directory>
    ```

2.  **Install dependencies:**
    Open a terminal in the project directory and run:
    ```sh
    flutter pub get
    ```

3.  **Run the app:**
    Connect a device or start an emulator/simulator, then run:
    ```sh
    flutter run
    ```

### Mock Credentials

Use the following credentials to log in to the app:
-   **Email**: `test@test.com`
-   **Password**: `password`

## Code Architecture & Decisions

This project emphasizes a clean, scalable, and maintainable codebase.

### 1. Feature-Based Organization

The code is structured by features (e.g., `auth`, `dashboard`, `settings`). This approach keeps related code together, making it easier to navigate, manage, and scale the application.