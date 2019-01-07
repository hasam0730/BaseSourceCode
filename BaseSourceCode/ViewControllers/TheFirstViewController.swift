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
    @IBOutlet weak var lblAgreementAndPolicy: TappableLabel!
	@IBOutlet weak var someView: UIView!
	@IBOutlet weak var otherView: GradientView!
	@IBOutlet weak var tapTextView: UITextView!
	
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
		print(somt.0.value(or: ""))
		print(somt.1.value(or: 0))
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
		//
		let struc = SomeStruct()
		struc.dosomething()
		print("🌴: \(struc.property)")
		
		let clas = SomeClass()
		print("🌴: \(clas.property)")
		clas.dosomething()
		//
		let value = "10.30"
		print(value.formatDecimalNumber(withDecimalPlace: 4).value(or: ""))
		
		let img = UIImage(named: "image1")?.resized(withPercentage: 0.1)
		print("🍉: \(img!.size)")
		
		checkValidate()
        //--------------
		
		tfMenu.callback = {
			self.dosomething()
		}
		
        //
		lblAgreementAndPolicy.displayableContentText = "Read A agreement and usually legally policy understanding between two or"
        lblAgreementAndPolicy.textColor = .black
		lblAgreementAndPolicy.backgroundColor = UIColor.green
        lblAgreementAndPolicy.isUserInteractionEnabled = true
		lblAgreementAndPolicy.detectableTextList = ["agreement", "legally policy"]
        lblAgreementAndPolicy.didDetectTapOnText = { string, indx in
			print("🍔\(string)-\(indx)")
        }
		
		lblAgreementAndPolicy.performPreparation()
		
		//
		UIView.animate(withDuration: 30) {
			self.otherView.frame.origin.x = 10
			self.someView.frame.origin.x = 2000
		}

		
		tapTextView.backgroundColor = .clear
		tapTextView.isScrollEnabled = false
		tapTextView.isEditable = false
		tapTextView.textContainerInset = .zero
		tapTextView.textContainer.lineFragmentPadding = 0
		
		let mutableAttributedString = NSMutableAttributedString(string: "More ways to shop: Visit an Apple Store, call 1-800-MY-APPLE, or find a reseller.")
		mutableAttributedString.setAsLink(textToFind: "Apple Store", linkName: "AppleStoreLink")
		mutableAttributedString.setAsLink(textToFind: "1-800-MY-APPLE", linkName: "ApplePhoneNumber")
		mutableAttributedString.setAsLink(textToFind: "find a reseller", linkName: "FindReseller")
		
		tapTextView.attributedText = mutableAttributedString
		
	}
	
	
	func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
		if URL.absoluteString == "AppleStoreLink" {
			// Handle action tap on AppleStoreLink
			print("Go to Apple Store")
			return true
		} else if URL.absoluteString == "ApplePhoneNumber" {
			// Handle action tap on ApplePhoneNumber
			print("Call to Apple Phone")
			return true
		} else if URL.absoluteString == "FindReseller" {
			// Handle action tap on FindReseller
			print("Find a Reseller")
			return true
		}
		return false
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
		//TicketPolicy
        let vc = PopUpAlert(nibName: "PopUpAlert", bundle: nil)
        let transitioner = ModalTransitioningDelegate()
		vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = transitioner
        //vc.smt = self.str.html2String
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
				self.tfMenu.setData(itemsList: str)
			}
		}
	}
}




extension NSMutableAttributedString {
	func setAsLink(textToFind:String, linkName:String) {
		let foundRange = self.mutableString.range(of: textToFind)
		if foundRange.location != NSNotFound {
			self.addAttribute(NSAttributedStringKey.link, value: linkName, range: foundRange)
		}
	}
}
