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
	@IBOutlet weak var someView: UIView!
	@IBOutlet weak var otherView: CustomView!
	@IBOutlet weak var btn: UIButton!
	
    let user = UserLogin(username: nil, email: "hasam@gmail.com")

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
    
    @IBAction func didSaveBtn(_ sender: UIButton) {
		do {
			try AuthController.shared.signIn(user: user, password: "tokencuahieu")
		} catch let error {
			print("🛶: \(error.localizedDescription)")
		}
    }
	
	@IBAction func getPassword(_ sender: UIButton) {
		do {
			let smt = try AuthController.shared.getPassword(user: user)
			
			showALert("Title", smt)
		} catch let error {
			showALert("", error.localizedDescription)
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
		
		tfMenu.callback = {
			self.dosomething()
		}
		
        //
        let label = TappableLabel()
        label.frame = CGRect(x: 150, y: 300, width: 200, height: 20)
        label.displayableContentText = "Hello World! stackoverflow"
        label.textColor = .black
		label.backgroundColor = UIColor.green
        label.isUserInteractionEnabled = true
        label.firstDetectableText = "World!"
        
        view.addSubview(label)
        
        let range = (label.displayableContentText! as NSString).range(of: "World", options: .caseInsensitive)
        label.didDetectTapOnText = { (value1, value2) in
            print("\(value1) - \(value2)\n")
            print("😇\(range.contains(value2.location))")
        }
        label.performPreparation()
        
        //
		
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
		
		//
		someView.addGradient(colors: [.green, .yellow], direction: .genkiApp)
		
		//
		UIView.animate(withDuration: 30) {
			self.otherView.frame.origin.x = 10
			self.someView.frame.origin.x = 2000
			self.btn.frame.origin.x = 0
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
    
    @IBAction func didTapShowPopUpBtn(_ sender: UIButton) {
        let vc = TicketPolicy(nibName: "TicketPolicy", bundle: nil)
        let transitioner = ModalTransitioningDelegate()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = transitioner
        vc.smt = self.str.html2String
        UIWindow.topViewController()?.present(vc, animated: true)
    }
	
	@IBAction func fetchingData(_ sender: UIButton) {
//		Post.fetchingData { (postsList, error) in
//			if let err = error {
//				self.showALert("", "\(err)")
//			} else if let data = postsList {
//				let str = data.map({
//					return $0.title
//				})
//				let smt = str.joined(separator: ", ")
//				self.showALert("", smt)
//			}
//		}
		
//		ResponseProvinceEntity.fetchingProvincesList { (data, error) in
//			if let err = error {
//				self.showALert("", "\(err)")
//			} else if let `data` = data {
//				let str = data.data.map({
//					return $0.name
//				})
//				let smt = str.joined(separator: ", ")
//				self.showALert("", data.msg)
//			}
//		}
		
		ResponsePostEntity.fetchingProvincesList { (data, error) in
			if let err = error {
				self.showALert("", "\(err)")
			} else if let uwrData = data {
				let str = uwrData.comments!.map({
					return $0.title
				})
				let smt = str.joined(separator: ", ")
				self.showALert("", smt)
			}
		}
		
//		Post.fetchingData { (post, error) in
//			if let err = error {
//				print(err)
//			} else if let p = post {
//				print(post)
//			}
//		}
		
	}
	
	func dosomething() {
		ResponsePostEntity.fetchingProvincesList { (data, error) in
			if let err = error {
				self.showALert("", "\(err)")
			} else if let uwrData = data {
				let str = uwrData.comments!.map({
					return $0.title
				})
//				let smt = str.joined(separator: ", ")
//				self.showALert("", smt)
				self.tfMenu.setData(itemsList: str)
			}
		}
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
