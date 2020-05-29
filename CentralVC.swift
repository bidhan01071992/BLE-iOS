//
//  CentralVC.swift
//  BLE-iOS
//
//  Created by Roy, Bidhan (623) on 29/05/20.
//  Copyright © 2020 Roy, Bidhan (623). All rights reserved.
//

import UIKit
import CoreBluetooth

class ParticlePeripheral: NSObject {

    /// MARK: - Particle LED services and charcteristics Identifiers

    public static let particleLEDServiceUUID     = CBUUID.init(string: "b4250400-fb4b-4746-b2b0-93f0e61122c6")
    public static let redLEDCharacteristicUUID   = CBUUID.init(string: "b4250401-fb4b-4746-b2b0-93f0e61122c6")
    public static let greenLEDCharacteristicUUID = CBUUID.init(string: "b4250402-fb4b-4746-b2b0-93f0e61122c6")
    public static let blueLEDCharacteristicUUID  = CBUUID.init(string: "b4250403-fb4b-4746-b2b0-93f0e61122c6")

}

class CentralVC: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        <#code#>
    }
    
    
     // Properties
       private var centralManager: CBCentralManager!
       private var peripheral: CBPeripheral!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
