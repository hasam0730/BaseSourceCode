//
//  View.swift
//  BaseSourceCode
//
//  Created by Developer on 8/12/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class TheFirstViewController: BaseSourceCode.ViewController, Alertable {
//    https://www.mockable.io/a/#/space/demo0368329/rest/UAAAAAAAA
	@IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tfMenu: MenuTextField!
    @IBOutlet weak var lblAgreementAndPolicy: UILabel!
    
    let user = UserLogin(username: nil, email: "hasam@gmail.com")
    var locationsList: [LocationEntity]?
    let str = """
        <HEAD>
        <TITLE>Your Title Here</TITLE>
        </HEAD>
        <BODY BGCOLOR="FFFFFF">
        <HR>
        <a href="http://somegreatsite.com">Link Name</a>
            is a link to another nifty site
        <H1>This is a Header</H1>
        <H2>This is a Medium Header</H2>
        Send me mail at <a href="mailto:support@yourcompany.com">
        support@yourcompany.com</a>.
        <P> This is a new paragraph!
        <P> <B>This is a new paragraph!</B>
        <BR> <B><I>This is a new sentence without a paragraph break, in bold italics.</I></B>
        <HR>
        </BODY>
        """
    
    @IBAction func didSelectBtn(_ sender: UIButton) {
		do {
			try AuthController.shared.signIn(user: user, password: "tokencuahieu")
		} catch let error {
			print("🛶: \(error.localizedDescription)")
		}
    }
	
	@IBAction func getPassword(_ sender: UIButton) {
		do {
			let smt = try AuthController.shared.getPassword(user: user)
			showALert(smt)
		} catch let error {
			showALert(error.localizedDescription)
		}
	}
	
	@IBAction func clearKeychain(_ sender: UIButton) {
		do {
			try AuthController.shared.clearPassword(user: user)
		} catch let error {
			print("🗿: \(error.localizedDescription)")
		}
	}
	
	
    @IBAction func didFetchData(_ sender: UIButton) {
		let somt = tfMenu.getSelectedData()
		print(somt.0.defaultIfNil)
		print(somt.1.defaultIfNil)
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
//        tfMenu.callback = {
//            self.requestData()
//        }
		
		tfMenu.callback = {
			self.requestData()
		}
		
		
		//----------------
        let attributeText = NSMutableAttributedString(string: "Bạn đã đồng ý ", attributes: nil)
        attributeText.append(NSAttributedString(string: "đồng ý", attributes: [NSAttributedStringKey.link: "", NSAttributedStringKey.foregroundColor: UIColor.red]))
        lblAgreementAndPolicy.attributedText = attributeText
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
    
    @IBAction func didTapShowPopUpBtn(_ sender: UIButton) {
//        let vc = TicketPolicy(nibName: "TicketPolicy", bundle: nil)
//        let transitioner = ModalTransitioningDelegate()
//        vc.modalPresentationStyle = .custom
//        vc.transitioningDelegate = transitioner
//        vc.smt = self.str.html2String
//        UIWindow.topViewController()?.present(vc, animated: true)
        
        if NetworkManager.isConnectedToInternet {
            showALert("connected")
        } else {
            showALert("disconnected")
        }
    }
    
    
    func requestData() {
        if locationsList != nil {
            let list = self.locationsList!.compactMap({
                return $0.name
            })
            self.tfMenu.setData(itemsList: list)
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
                            self.tfMenu.setData(itemsList: list)
                        }
                    }
                }
            }
        }
        task.resume()
    }
}
