# Murafik – Smart Healthcare & Seizure Monitoring System

## Overview

Murafik is an intelligent healthcare companion system designed to improve the patient journey through real-time health monitoring, wearable sensor integration, and seamless communication between patients, doctors, supervisors, and healthcare organizations.

The system combines a Flutter mobile application, backend APIs, biomedical wearable sensors, and a hospital management dashboard into one integrated healthcare ecosystem.

Murafik focuses on:

* Real-time patient monitoring
* Seizure and abnormal activity detection
* Healthcare workflow management
* Remote medical supervision
* Smart patient engagement

---

# System Architecture

Murafik consists of three main components:

## 1. Mobile Application

A Flutter-based mobile app used by:

* Patients
* Doctors
* Supervisors

The application provides real-time monitoring, alerts, communication, and healthcare management features.

---

## 2. Backend System

A scalable backend system responsible for:

* Authentication & authorization
* Managing healthcare data
* Processing sensor readings
* Handling alerts & notifications
* Connecting all system components

---

## 3. Hospital Dashboard

A web-based dashboard designed for hospitals and healthcare organizations.

The dashboard allows administrators to:

* Add and manage patients
* Add and manage doctors
* Add and manage supervisors
* Monitor patient statistics
* Track alerts and emergencies
* Manage healthcare workflows

---

# Key Features

## Patient Features

* Real-time health monitoring
* View biomedical sensor readings
* Receive emergency alerts
* Track health statistics
* Manage appointments & follow-ups
* Connect with assigned doctors

---

## Doctor Features

* Remote patient monitoring
* Access patient medical readings
* View patient alerts and emergencies
* Analyze patient history
* Monitor priority patients

---

## Supervisor Features

* Monitor healthcare workflow
* Review patient statistics
* Access alerts and readings
* Track patient activity

---

## Hospital Dashboard Features

* Centralized healthcare management
* User & role management
* Patient assignment system
* Real-time monitoring dashboard
* Alerts tracking system
* Analytics & statistics

---

# Wearable Biomedical Sensors

Murafik integrates with biomedical wearable hardware devices to collect and analyze physiological data in real time.

## Integrated Sensors

### GSR (Galvanic Skin Response)

Measures skin electrical resistance.

Used for:

* Stress detection
* Emotional monitoring
* Seizure indication analysis

---

### NIR (Near Infrared Sensor)

Used for:

* SpO₂ monitoring
* PPG signal measurement
* Blood oxygen tracking

Compatible with sensors like:

* MAX30102

---

### ECG (Electrocardiogram)

Measures electrical activity of the heart.

Used for:

* Heart rate monitoring
* Arrhythmia detection
* Cardiac health analysis

---

### EMG (Electromyography)

Measures electrical activity of muscles.

Used for:

* Muscle movement monitoring
* Seizure/spasm detection

---

### Accelerometer & Gyroscope

Measures:

* Motion
* Orientation
* Sudden body movement

Used for:

* Fall detection
* Seizure movement detection
* Activity tracking

---

### Temperature Sensor

Measures body temperature continuously.

Used for:

* Fever detection
* Health condition monitoring

---

# Tech Stack

## Mobile Development

* Flutter
* Dart

## Architecture

* Clean Architecture
* Feature-First Structure
* Domain / Data / Presentation Layers

## State Management

* BLoC / Cubit

## Networking

* Dio
* REST APIs

## Authentication & Security

* JWT Authentication
* Bearer Token Authorization
* Dio Interceptors

## Dependency Injection

* GetIt

## Navigation

* GoRouter

## Local Storage

* SharedPreferences

## Additional Packages

* Dartz
* Equatable
* SmoothPageIndicator
* URL Launcher

---

# Project Structure

```bash id="ot2d9r"
lib/
│
├── core/
│   ├── errors/
│   ├── network/
│   ├── utils/
│   ├── services/
│   └── di/
│
├── features/
│   │
│   ├── auth/
│   ├── patient/
│   ├── doctor/
│   └── supervisor/
│
└── main.dart
```

---

# Authentication Flow

Murafik uses secure JWT-based authentication.

## Authentication Process

1. User logs in
2. Backend returns JWT token
3. Token stored securely
4. Requests automatically include Bearer token
5. Protected features become accessible

---

# Clean Architecture

The project follows Clean Architecture principles.

## Layers

### Presentation Layer

Handles:

* UI
* Cubits/BLoCs
* User interaction

### Domain Layer

Handles:

* Business logic
* Use cases
* Repository contracts

### Data Layer

Handles:

* API communication
* Models
* Repository implementations

---

# Innovation & Smart Features

Murafik is not just a healthcare application.

It is a complete smart healthcare ecosystem that combines:

* Biomedical wearable technology
* Real-time health monitoring
* Remote healthcare management
* Seizure detection support
* Hospital workflow automation
* Multi-role healthcare communication

---

# Future Improvements

* AI-based seizure prediction
* Machine learning health analytics
* Real-time emergency notifications
* Smartwatch integration
* Cloud synchronization
* Voice assistant integration
* Medical report generation
* Predictive healthcare analytics

---

# Installation

## Clone Repository

```bash id="jaj2hp"
git clone https://github.com/your-username/murafik.git
```

---

## Navigate to Project

```bash id="g3bwbk"
cd murafik
```

---

## Install Dependencies

```bash id="a1msaf"
flutter pub get
```

---

## Run Application

```bash id="v8a3q0"
flutter run
```

---

# Requirements

* Flutter SDK
* Dart SDK
* Android Studio / VS Code
* Emulator or Physical Device

---

# Contributors

* Mobile Development Team
* Backend Development Team
* Embedded Systems Team
* Healthcare Monitoring Team

---

# License

This project is developed for educational, healthcare, and research purposes.

---

# Vision

Murafik aims to bridge the gap between wearable healthcare technology and modern healthcare systems by creating a smart, scalable, and real-time patient monitoring ecosystem capable of improving patient safety and healthcare efficiency.

