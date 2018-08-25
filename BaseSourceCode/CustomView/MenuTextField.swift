//
//  MenuTextField.swift
//  BaseSourceCode
//
//  Created by hasam on 8/25/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class MenuTextField: IconTextField {

    var dataList: [String]!
    var value: String?
    private var tempedView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    private func setupView() {
        
        let textViewRecognizer = UITapGestureRecognizer()
        textViewRecognizer.addTarget(self, action: #selector(dosomething(_:)))
        
        addGestureRecognizer(textViewRecognizer)
    }
    
    private func handleLoadingIndicator() {
        tempedView = rightView
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.startAnimating()
        rightView = indicator
    }
    
    @objc private func dosomething(_ sender: UITapGestureRecognizer) {
        guard dataList != nil else { fatalError("dataList is nil") }
        
        handleLoadingIndicator()
        
        let vc = OptionsListViewController(nibName: "OptionsListViewController", bundle: nil)
        vc.stringList = dataList
        vc.didSelect = {[weak self](data: String) in
            self?.value = data
            UIWindow.topViewController()?.dismiss(animated: true, completion: {
                self?.rightView = self?.tempedView
                self?.text = data
            })
        }
        UIWindow.topViewController()?.present(vc, animated: true)
    }
}

