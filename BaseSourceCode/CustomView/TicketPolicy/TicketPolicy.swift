//
//  TicketPolicy.swift
//  DemoHTML
//
//  Created by mac mini on 9/10/18.
//  Copyright © 2018 ESMAC. All rights reserved.
//

import UIKit

class TicketPolicy: PopupViewController {

    @IBOutlet weak var lblPolicy: UILabel!
//    var smt: NSAttributedString!
    var smt: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        lblPolicy.attributedText = smt
        lblPolicy.text = smt
    }
}
