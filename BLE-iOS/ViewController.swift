//
//  ViewController.swift
//  BLE-iOS
//
//  Created by Roy, Bidhan (623) on 29/05/20.
//  Copyright © 2020 Roy, Bidhan (623). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func navigateToPeripheralScreen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let peripheralVC = storyboard.instantiateViewController(identifier: "PeripheralVC") as? PeripheralVC {
            self.navigationController?.pushViewController(peripheralVC, animated: true)
        }
    }
    
    @IBAction func navigateToRecieveScreen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let centralVC = storyboard.instantiateViewController(identifier: "CentralVC") as? CentralVC {
            self.navigationController?.pushViewController(centralVC, animated: true)
        }
    }
}

