# MVVM-C

This project follows MVVM-C architecture.

## Overview

![MVVM-C Architecture](mvvmc.png)

Each scene has a viewController, viewModel, coordinator and storyboard file. ViewController is represented by UIViewController designed in storyboard. ViewModel is the place where contains the logic. It calls API requests, creates or modifies model objects and interacts with the coordinator. It is UIKit independent. ViewController calls methods in ViewModel when needed. Navigation through different scenes is achieved by a coordinator.

ViewController -> View Model -> Coordinator
