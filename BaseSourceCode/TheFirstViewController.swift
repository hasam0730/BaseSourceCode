//
//  View.swift
//  BaseSourceCode
//
//  Created by Developer on 8/12/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class TheFirstViewController: BaseSourceCode.ViewController {
//    https://www.mockable.io/a/#/space/demo0368329/rest/UAAAAAAAA
	@IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tfMenu: MenuTextField!
    
    var locationsList: [LocationEntity]?
    
    @IBAction func didSelectBtn(_ sender: UIButton) {
        print("😀: \(tfMenu.value.defaultIfNil)")
    }
    
    @IBAction func didFetchData(_ sender: UIButton) {

    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
		//
		let value = "10.30"
		print(value.formatDecimalNumber(withDecimalPlace: "2").defaultIfNil)
		
		let img = imageView.resizeImage(image: #imageLiteral(resourceName: "image"), with: CGSize(width: 100, height: 50))
		imageView.image = img
		
		checkValidate()
        
        //--------------
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
//        formatter.groupingSeparator = Locale.current.groupingSeparator
//        formatter.groupingSeparator = Locale(identifier: "FR_fr").groupingSeparator
        
        let amount = 2358000
        let formattedString = formatter.string(for: amount)
        print(formattedString.defaultIfNil)
        
        //--------------
        tfMenu.callBackToSetData = {
            self.requestData()
        }
	}
	
	func checkValidate() {
		let result = ValidateHandler.isCorrect(formatter: .phoneNumber, string: "")
		switch result {
		case .Success(let mess):
			print(mess)
		case .Failure(let mess):
			print(mess)
		}
		
	}
    
    func requestData() {
        if locationsList != nil {
            let list = self.locationsList!.compactMap({
                return $0.name
            })
            self.tfMenu.dataList = list
            return
        }
        let url = URL(string: "http://demo0368329.mockable.io/dataList")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                print(error.debugDescription)
            } else {
                if let usableData = data {
                    let dicData = try! JSONSerialization.jsonObject(with: usableData, options: [])
                    if let uwrdata = dicData as? [String: Any], let data = uwrdata["data"] as? [[String: Any]] {
                        self.locationsList = [LocationEntity]()
                        data.forEach({
                            let location = LocationEntity(dicData: $0)
                            self.locationsList?.append(location)
                        })
                        let list = self.locationsList!.compactMap({
                            return $0.name
                        })
                        DispatchQueue.main.async {
                            self.tfMenu.dataList = list
                        }
                    }
                }
            }
        }
        task.resume()
    }
}
