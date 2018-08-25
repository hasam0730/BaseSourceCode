//
//  MenuTextField.swift
//  BaseSourceCode
//
//  Created by hasam on 8/25/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class MenuTextField: IconTextField {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let textViewRecognizer = UITapGestureRecognizer()
        textViewRecognizer.addTarget(self, action: #selector(dosomething(_:)))
        
        addGestureRecognizer(textViewRecognizer)
    }
    
    @objc func dosomething(_ sender: UITapGestureRecognizer) {
        let vc = OptionsListViewController(nibName: "OptionsListViewController", bundle: nil)
        vc.didSelect = {(data: String) in
            UIWindow.topViewController()?.dismiss(animated: true, completion: {
                self.text = data
            })
        }
        UIWindow.topViewController()?.present(vc, animated: true)
    }
}

