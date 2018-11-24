//
//  CustomViewController.swift
//  BaseSourceCode
//
//  Created by Developer on 11/24/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

	@IBOutlet weak var topSwitch: Switch!
	@IBOutlet weak var bottomSwitch: Switch!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	@IBAction func topSwitchChangeState(_ sender: Switch) {
		bottomSwitch.set(to: sender.isOn)
	}
}
