# 🏥 Patient Dashboard Flutter App

A **cross-platform mobile app** that empowers patients to easily view their **dashboard**, **medication status**, and **shipment history**.  
This project focus on clean architecture, modern state management, and delivering a smooth user experience.

---

## ✨ Features

- 🔐 **Authentication**  
  Secure login screen using mock credentials:  
  `test@test.com / password`

- 📱 **Session Persistence**  
  Keeps users logged in across app restarts using `shared_preferences`

- 📊 **Dashboard Overview**  
  Displays key patient information including:
   - Full Name & Patient ID
   - Current Plan
   - Next Delivery Date
   - Remaining Medication
   - Status Summary (Active/Inactive, Billing OK)

- 📦 **Shipment History**  
  Scrollable, efficient list of past shipments rendered with `ListView.builder`

- 🎨 **Custom Animations**  
  Subtle fade-in and slide animations enhance the shipment history UI

- 🚦 **Navigation**  
  Built with `go_router` and a persistent bottom navigation bar for smooth screen transitions

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK
- VS Code or Android Studio with Flutter plugin installed

### Setup & Run

git clone https://github.com/yourusername/patient_dashboard_app.git
cd patient_dashboard_app
flutter pub get
flutter run

---

## 🏗️ Code Architecture & Decisions

- **Feature-Based Modularization**  
  Organizes code by features (`auth`, `dashboard`, `settings`) for better maintainability and scalability.

- **State Management**  
  Utilizes BLoC pattern for separation of concerns and predictable state changes.

- **Clean Architecture Principles**  
  Enforces separation between UI, business logic, and data layers for testability and reusability.

---

## 🚦 Production Deployment Plan

| Step                    | Description                                                                                                   |
|-------------------------|--------------------------------------------------------------------------------------------------------------|
| **CI/CD Workflow**      | Automated pipelines (GitHub Actions/GitLab CI) run unit tests, code analysis, and build `.apk` & `.ipa`.      |
| **Automated Submission**| Fastlane automates code signing, release notes generation, and app store submission to Apple & Google stores. |
| **Secrets Management**  | Securely stores keys and credentials in CI secrets to avoid exposure; injected only during builds.            |

---

## 🎥 Demo

Watch the app in action here: (https://drive.google.com/file/d/1zBbU-jfE0Rv7wt7v_dxn9oVOObBUhRyA/view?usp=sharing)
