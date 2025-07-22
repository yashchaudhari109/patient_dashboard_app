Patient Dashboard Flutter App
A cross-platform mobile app for patients to view their dashboard, medication status, and shipment history. This project was built to fulfill the requirements of a take-home assignment, focusing on clean architecture, modern state management, and high-quality user experience.

Features
Authentication: Secure login screen using mock credentials (test@test.com / password).

Session Persistence: Keeps the user logged in across app restarts using shared_preferences.

Dashboard: A clear and concise dashboard displaying key patient information:

Full Name & Patient ID

Current Plan

Next Delivery Date

Remaining Medication

Status Summary (Active/Inactive, Billing OK)

Shipment History: An efficient, scrollable list of past shipments rendered with ListView.builder.

Custom Animations: Subtle fade-in and slide animations on the shipment history list to enhance the UI.

Navigation: Implemented using go_router with a persistent bottom navigation bar for seamless screen transitions.

Getting Started
Prerequisites
Flutter SDK (version 3.0 or higher recommended).

A code editor like VS Code or Android Studio with Flutter plugin.

Setup & Run
bash
git clone https://github.com/yourusername/patient_dashboard_app.git
cd patient_dashboard_app
flutter pub get
flutter run
Mock Credentials
Use the following credentials to log in to the app:

Email: test@test.com

Password: password

Code Architecture & Decisions
This project emphasizes a clean, scalable, and maintainable codebase.

1. Feature-Based Organization
   The code is structured by features (e.g., auth, dashboard, settings). This approach keeps related code together, making it easier to navigate, manage, and scale the application.

Production Deployment Plan
This section outlines the strategy for building, deploying, and maintaining the Patient Dashboard app in production environments.

1. CI/CD Workflow
   Automated CI pipelines (e.g., GitHub Actions, GitLab CI) will be configured to run unit tests, analyze code quality, and build platform-specific binaries (.apk for Android and .ipa for iOS) on every push or pull request to the main branch.
   Builds will be triggered automatically upon code merge, ensuring consistent and reliable production-quality artifacts.

2. Automated Submission
   Continuous delivery tools such as Fastlane will be used for automatic submission to the Apple App Store and Google Play Store.
   Upon successful build, Fastlane will handle signing, generate release notes, and upload binaries seamlessly to the respective app stores, reducing manual overhead and speeding up deployment.

3. Secrets Management
   Sensitive files and credentials (Android keystore, Apple certificates, API keys) will be stored securely in the CI platform's secret management system.
   Access to these secrets is restricted and injected only during the build process to protect them from exposure.
   Environment variables ensure that credentials are never committed to source code repositories.

Additional Sections Covered
Setup & Build Instructions: How to get the code, dependencies, and run locally on devices/emulators.

Architecture Decisions: Description of feature-based modular code organization, BLoC for state management, and clean separation of concerns.

Demo Video: https://drive.google.com/file/d/1zBbU-jfE0Rv7wt7v_dxn9oVOObBUhRyA/view?usp=sharing