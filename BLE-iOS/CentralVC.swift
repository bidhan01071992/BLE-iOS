//
//  CentralVC.swift
//  BLE-iOS
//
//  Created by Roy, Bidhan (623) on 29/05/20.
//  Copyright © 2020 Roy, Bidhan (623). All rights reserved.
//

import UIKit
import CoreBluetooth

class CentralVC: UIViewController {
    
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var infoLbl: UILabel!
    
     

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        infoLbl.text = "This version will scan for all the BLE peripherals \n this scanning should support background scan also.\n\n All the peripherals scanned will be shown in a list next page. Please tap on scan button in order to start scanning."
        
    }
    
    @IBAction func scanStartStopAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let scannedPeriPheralList = storyboard.instantiateViewController(identifier: "ScannedPeriPheralList") as? ScannedPeriPheralList {
            self.navigationController?.pushViewController(scannedPeriPheralList, animated: true)
        }
    }
    
}
