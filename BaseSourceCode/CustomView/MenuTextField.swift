//
//  MenuTextField.swift
//  BaseSourceCode
//
//  Created by hasam on 8/25/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class MenuTextField: IconTextField {

	let interactor = Interactor()
    private var value: String?
	private var selectedIndex: Int?
    private var tempedView: UIView?
    private var dataList: [String]? {
        didSet {
            guard let uwrDataList = dataList else { return }
            let vc = OptionsListViewController(nibName: "OptionsListViewController", bundle: nil)
            vc.stringList = uwrDataList
			vc.modalPresentationStyle = .custom
			// present list view
            UIWindow.topViewController()?.present(vc, animated: true, completion: {
                vc.didSelect = {[weak self](data: String?) in
					if let uwrData = data {
						self?.value = uwrData
						self?.selectedIndex = uwrDataList.index(of: uwrData)
					}
					self?.rightView = self?.tempedView
					// dismiss list view
                    UIWindow.topViewController()?.dismiss(animated: true, completion: {
                        self?.rightView = self?.tempedView
                        if self?.tempedView == nil {
                            self?.rightViewMode = .never
                        }
                        self?.text = data
                    })
                }
            })
        }
    }
    
    var callback: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
	
	func setData(itemsList: [String]) {
		dataList = itemsList
	}
	
	func getSelectedData() -> (String?, Int?) {
		return (value, selectedIndex)
	}
	
    private func setupView() {
        tintColor = .clear
        
        let textViewRecognizer = UITapGestureRecognizer()
        textViewRecognizer.addTarget(self, action: #selector(didTapTextField(_:)))
        
        addGestureRecognizer(textViewRecognizer)
    }
    
    private func startingLoadingAnimation() {
		rightViewMode = .always
        tempedView = rightView
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.startAnimating()
        rightView = indicator
    }
    
    @objc private func didTapTextField(_ sender: UITapGestureRecognizer) {
        startingLoadingAnimation()
        callback?()
    }
}
