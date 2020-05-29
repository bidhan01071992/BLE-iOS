//
//  ScannedPeriPheralList.swift
//  BLE-iOS
//
//  Created by Roy, Bidhan (623) on 29/05/20.
//  Copyright © 2020 Roy, Bidhan (623). All rights reserved.
//

import UIKit
import CoreBluetooth

class ScannedPeriPheralList: UITableViewController {

    // Properties
    private var centralManager: CBCentralManager!
    private var peripheral: CBPeripheral!
    
    private var peripheralList : [CBPeripheral] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return peripheralList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell") {
            cell.textLabel?.text = peripheralList[indexPath.row].name ?? "Unknown"
            return cell
        }
        
        return UITableViewCell()
    }
}

extension ScannedPeriPheralList: CBCentralManagerDelegate, CBPeripheralDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Central state update")
        if central.state != .poweredOn {
            print("Central is not powered on")
        } else {
            centralManager.scanForPeripherals(withServices: nil,
                                              options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
        }
    }
    
    // Handles the result of the scan
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
            if let name = peripheral.name {
                for peripheral in peripheralList {
                    if peripheral.name == name {
                        return;
                    }
                }
                peripheralList.append(peripheral)
                self.tableView.reloadData()
            }
        }
}
