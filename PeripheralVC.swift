//
//  PeripheralVC.swift
//  BLE-iOS
//
//  Created by Roy, Bidhan (623) on 29/05/20.
//  Copyright © 2020 Roy, Bidhan (623). All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class PeripheralVC: UIViewController {

    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var udidLabel: UILabel!
    @IBOutlet weak var errorLbl: UILabel!
    
    private var service: CBUUID!
    private let value = "Bidhan-Test"
    var peripheral: CBPeripheralManager? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        infoLbl.text = "Any iOS device that supports data using BLE can be turned into a peripheral or beacon \n\n Apps that use their underlying iOS device as an iBeacon must always run in the foreground.\n\nTo use an iOS device as an iBeacon, you do the following:\n\n1) Obtain or generate a 128-bit UUID for your device.\n\n2) Create a CLBeaconRegion object containing the UUID value along with appropriate major and minor values for your beacon.\n\n3) Advertise the beacon information using the Core Bluetooth framework."
        if let udid = generateUDID() {
            udidLabel.text = "Device UDID is - \(udid)"
        }
        
        peripheral = CBPeripheralManager(delegate: self, queue: nil)
        
    }
    
    @IBAction func startBroadcastingAction(_ sender: Any) {
        if let beaconRegion = createBeaconRegion() {
            advertiseDesign(region: beaconRegion)
        }
        
    }
    
    private func generateUDID() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    private func setTextToErrorLbl(message: String, isError: Bool) {
        if isError {
            errorLbl.textColor = .red
        } else {
            errorLbl.textColor = .green
        }
        errorLbl.text = message;
    }
    
    ///Configure the Beacon Region
    ///
    ///
    ///Use a CLBeaconRegion object to configure your beacon’s identity. You use the beacon region to generate a dictionary of information that you can advertise later over Bluetooth.
    ///import Corlocation framework to use this
    
    func createBeaconRegion() -> CLBeaconRegion? {
        guard let udidStr = generateUDID(), let proximityUUID = UUID(uuidString: udidStr) else {
            return nil
        }
        
        let major : CLBeaconMajorValue = 100
        let minor : CLBeaconMinorValue = 1
        let beaconId = "Sample Text"
        
        return CLBeaconRegion(uuid: proximityUUID, major: major, minor: minor, identifier: beaconId)
    }
    
    ///Advertise Your Beacon Over Bluetooth
    ///
    ///
    ///To broadcast your beacon’s identity from an iOS device, use the Core Bluetooth framework to configure the iOS device as a Bluetooth peripheral. When configured as a peripheral, your iOS device broadcasts its beacon information out to other devices using the Bluetooth hardware. Other devices use that information to perform ranging and detect their proximity to your iOS device.
    ///
    ///The startAdvertising(_:) method takes a dictionary parameter that contains your beacon information.
    ///
    ///When calling the peripheralData(withMeasuredPower:) method to obtain your data dictionary, you typically pass nil to specify the default received signal strength indicator (RSSI) value associated with the iOS device.
    func advertiseDesign(region: CLBeaconRegion) {
        
        if peripheral?.state != .poweredOn {
            setTextToErrorLbl(message: "Turn on your bluetooth first", isError: true)
            return
        }
        addServices(peripheralManager: peripheral!)
        if let peripheralData = region.peripheralData(withMeasuredPower: nil) as? [String : Any] {
//            peripheral?.startAdvertising(peripheralData)
            peripheral?.startAdvertising([CBAdvertisementDataLocalNameKey : "BLEPeripheralApp", CBAdvertisementDataServiceUUIDsKey :     [service]])
        }
    }
    
    ///If the bluetooth is on, we need to add services and characteristics to the peripheral application which it exposes to the client device while advertising.
    ///
    ///We create the characteristic by instantiating CBMutableCharacteristic. It takes type 4 parameters. Type, of type CBUUID, provides a unique identifier to the characteristic. Properties, which define whether a characteristic should be able to read, write or notify. Value, which is the characteristic value to be read by central device. And last is permission which tells either the characteristic is readable or writable or both.
    ///Create service of type CBMutable with new CBUUID specifying its type and whether it is a primary service or not.
    ///Add the previously created Characteristics to the service.
    ///Then add the service to peripheral using peripheralManager.
    
    func addServices(peripheralManager: CBPeripheralManager) {
        let valueData = value.data(using: .utf8)
         //Creating iOS application as Bluetooth PeripheralCreating iOS application as Bluetooth Peripheral
         // 1. Create instance of CBMutableCharcateristic
        let myChar1 = CBMutableCharacteristic(type: CBUUID(nsuuid: UUID()), properties: [.notify, .write, .read], value: nil, permissions: [.readable, .writeable])
        let myChar2 = CBMutableCharacteristic(type: CBUUID(nsuuid: UUID()), properties: [.read], value: valueData, permissions: [.readable])
        // 2. Create instance of CBMutableService
        service = CBUUID(nsuuid: UUID())
        let myService = CBMutableService(type: service, primary: true)
        // 3. Add characteristics to the service
        myService.characteristics = [myChar1, myChar2]
        // 4. Add service to peripheralManager
        peripheralManager.add(myService)
    }
    
    
}

extension PeripheralVC: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .unknown:
            setTextToErrorLbl(message: "Oh no! some unknown error occurred", isError: true)
            break
        case .unsupported:
            setTextToErrorLbl(message: "Oh no! some unsupported error occurred", isError: true)
            break
        case .unauthorized:
            setTextToErrorLbl(message: "You are not authorized to use BLE", isError: true)
            break
        case .resetting:
            setTextToErrorLbl(message: "Seems like BLE is trying to reconnect. please wait a bit", isError: true)
            break
        case .poweredOff:
            setTextToErrorLbl(message: "Your bluetooth is powered off. Please turn it on", isError: true)
            break
        case .poweredOn:
            setTextToErrorLbl(message: "Bluetooth is available for use", isError: false)
            break
        default:
            setTextToErrorLbl(message: "Oh no! some unknown error occurred", isError: true)
        }
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        peripheral.isAdvertising == true ? setTextToErrorLbl(message: "Broadcasting Start", isError: false) : setTextToErrorLbl(message: "Broadcasting is not started", isError: true)
    }
    
}
