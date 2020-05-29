# BLE-iOS

## Bluetooth Framework ##

Developing apps for sensors primarily involves using the **Core Bluetooth framework**, while developing apps for **iBeacon** primarily involves the **Core Location framework** (ANCS does not require an app).

Its **CBCentralManager** and CBPeripheral classes allow you to work with the centrals and peripherals. **CBCentralManager** provides resources for scanning, discovering, and connecting to remote peripherals, while **CBPeripheral** provides resources for working with services and characteristics that are part of the remote peripheral.

## Turning an iOS Device into an iBeacon Device ##

Any iOS device that supports sharing data using Bluetooth low energy can be turned into an iBeacon. Apps that use their underlying iOS device as an iBeacon must run in the foreground. 

**To use an iOS device as an iBeacon, you do the following:**
1) Obtain or generate a 128-bit UUID for your device.
2) Create a CLBeaconRegion object containing the UUID value along with appropriate major and minor values for your beacon.
3) Advertise the beacon information using the Core Bluetooth framework.
