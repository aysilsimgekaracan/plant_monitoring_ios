# Scenes

## Overview

This document provides an overview of the key components within the application, including Coordinators, ViewControllers, and ViewModels for each major feature.

### Application Coordinator

The Application Coordinator handles the root flow of the application. It manages the transitions between the splash screen, onboarding, and main tab bar.

- ``ApplicationCoordinator``
- ``Coordinator``
- ``TabBarCoordinator``

### Onboarding

The onboarding flow is responsible for introducing the user to the app's features.

- ``OnboardingViewController``
- ``OnboardingViewModel``
- ``OnboardingCoordinator``

### Splash

The splash screen is the first screen displayed when the app launches.

- ``SplashViewController``
- ``SplashViewModel``
- ``SplashCoordinator``

### Home

The home screen provides the main functionality of the application once the user has completed onboarding.

- ``HomeViewController``
- ``HomeViewModel``
- ``HomeCoordinator``

### Plants

The Plants section allows users to view and manage their plants.

- ``PlantsViewController``
- ``PlantsViewModel``
- ``PlantsCoordinator``

### Plant Detail

This section provides detailed information about a specific plant, including its status and history.

- ``PlantDetailViewController``
- ``PlantDetailViewModel``
- ``PlantDetailCoordinator``

### Add Plant

The Add Plant flow allows the user to add a new plant to their collection.

- ``AddPlantViewController``
- ``AddPlantViewModel``
- ``AddPlantCoordinator``

### Add Device

The Add Device flow lets users link a device to their plant for monitoring.

- ``AddDeviceViewController``
- ``AddDeviceViewModel``
- ``AddDeviceCoordinator``

## See Also

For more detailed information about each component, please refer to their specific documentation.
