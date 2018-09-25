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
    @IBOutlet weak var textView: UITextView!
    
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
		
		tfMenu.callback = {
			self.requestData()
		}
		
        //
        let label = TappableLabel()
        label.frame = CGRect(x: 150, y: 300, width: 200, height: 20)
        label.displayableContentText = "Hello World! stackoverflow"
        label.textColor = .black
		label.backgroundColor = UIColor.green
        label.isUserInteractionEnabled = true
        label.detectableText = "World!"
        
        view.addSubview(label)
        
        let range = (label.displayableContentText! as NSString).range(of: "World", options: .caseInsensitive)
        label.didDetectTapOnText = { (value1, value2) in
            print("\(value1) - \(value2)\n")
            print("😇\(range.contains(value2.location))")
        }
        label.performPreparation()
        
        //
        
//         textView.linkTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.red]
//        let attributedString = NSMutableAttributedString(string: "Tôi đã đọc và đồng ý với các Quy định bảo mật và Thoả thuận sử dụng")
//		attributedString.addAttributes([.link: "a", .font: UIFont.boldSystemFont(ofSize: 15), .foregroundColor: UIColor.red], range: NSRange(location: 28, length: 17))
//        attributedString.addAttributes([.link: "b", .font: UIFont.boldSystemFont(ofSize: 15), .foregroundColor: UIColor.red], range: NSRange(location: 48, length: 19))
//        attributedString.addAttributes([.font: UIFont.boldSystemFont(ofSize: 20), .foregroundColor: UIColor.red], range: NSRange(location: 0, length: 28))
//        attributedString.addAttributes([.font: UIFont.boldSystemFont(ofSize: 20), .foregroundColor: UIColor.red], range: NSRange(location: 46, length: 2))
//        textView.attributedText = attributedString
//        textView.delegate = self
		
		textView.text = "Tôi đã đọc và Quy định bảo mật"
		textView.textColor = .black
		let policyString = "Tôi đã đọc và"
		let termString = "Quy định bảo mật"
		let string = policyString + termString
		let attributedString = NSMutableAttributedString(string: string)
		let policyIndex = string.distance(from: string.startIndex, to:(string.range(of: policyString)!.lowerBound))
		let termIndex = string.distance(from: string.startIndex, to:(string.range(of: termString)!.lowerBound))
		attributedString.addAttribute(.link, value: "policy", range: NSRange(location: policyIndex, length: policyString.count))
		attributedString.addAttribute(.link, value: "term", range: NSRange(location: termIndex, length: termString.count))
		
		attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: policyIndex, length: policyString.count))
		attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: termIndex, length: termString.count))
		
		attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 12), range: NSRange(location: 0, length: string.utf16.count))
		attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: string.utf16.count))
		
		textView.linkTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
		textView.attributedText = attributedString
		textView.isEditable = false
		textView.isSelectable = true
		textView.delegate = self
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
        let vc = TicketPolicy(nibName: "TicketPolicy", bundle: nil)
        let transitioner = ModalTransitioningDelegate()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = transitioner
        vc.smt = self.str.html2String
        UIWindow.topViewController()?.present(vc, animated: true)
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

extension TheFirstViewController: UITextViewDelegate {
	
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "a" {
            print("GOOD")
        }
		
        if URL.absoluteString == "b" {
            print("GOOD 111")
        }
        return true
    }
}
