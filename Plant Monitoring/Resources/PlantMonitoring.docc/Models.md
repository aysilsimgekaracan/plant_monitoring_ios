# Models

This section describes the models used in the **Plant Monitoring** project. Models represent the data structures exchanged between the client and the server.


## Overview

The models in this project are built using Swift's `Codable` protocol, which makes it easier to serialize and deserialize data for network communication. These models are designed to represent various entities such as plants, devices, and sensor data.

### Plant Model

The `Plant` model represents a plant in the system, containing attributes such as the plant's name, type, location, and description.

```swift
struct Plant: Codable {
    var id: String
    var name: String
    var type: String
    var location: String
    var description: String
}
```

#### Properties

- `id`: A unique identifier for the plant.
- `name`: The name of the plant.
- `type`: The type or species of the plant.
- `location`: The location where the plant is being monitored.
- `description`: Additional information about the plant.

#### Models
- ``CreatePlantItem``
- ``UploadPlantImageItem``
- ``PlantsItem``

#### Tasks
- ``CreatePlantTask``
- ``UploadPlantImageTask` 
- ``GetPlantsTask``

### SensorOutput Model

The SensorOutput model represents the sensor data collected for a plant.

```swift
struct SensorOutput: Codable {
    var plantId: String
    var temperature: Float
    var humidity: Float
    var soilMoisture: Float
}
```

#### Properties

- `plantId`: A reference to the plant for which the data was collected.
- `temperature`: The temperature in the plant’s environment.
- `humidity`: The humidity level around the plant.
- `soilMoisture`: The moisture level in the plant’s soil.

### Device Model

The Device model represents a physical device that collects data from a plant or controls its environment (e.g., watering devices).

```swift
struct Device: Codable {
    var id: String
    var deviceName: String
    var plantId: String?
    var serialNumber: String
}
```

#### Properties

- `id`: A unique identifier for the device.
- `deviceName`: The name or label given to the device.
- `plantId`: (Optional) The identifier of the plant that the device is associated with. If the device is not linked to a plant, this value can be `nil`.
- `serialNumber`: The serial number of the device, which serves as an additional identifier.

#### Models
- ``DevicesItem``
- ``AvailableDevicesItem``

#### Tasks
- ``GetDevicesTask``
- ``GetAvailableDevicesTask``
