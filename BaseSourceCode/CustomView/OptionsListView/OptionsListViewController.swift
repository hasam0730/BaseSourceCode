//
//  OptionsListViewController.swift
//  BaseSourceCode
//
//  Created by hasam on 8/25/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class OptionsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var stringList: [String]!
    var didSelect: ((_ data: String?) -> Void)?
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		modalPresentationStyle = .custom
		transitioningDelegate = self
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		
//		modalPresentationStyle = .custom
//		self.transitioningDelegate = self
//		
		//
		let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(close))
		gestureRecognizer.cancelsTouchesInView = false
		gestureRecognizer.delegate = self
		view.addGestureRecognizer(gestureRecognizer)

    }
	
	@objc func close() {
		dismiss(animated: true, completion: nil)
		didSelect?(nil)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension OptionsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stringList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = stringList[indexPath.row]
        return cell!
    }
}

extension OptionsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelect?(stringList[indexPath.row])
    }
}

extension OptionsListViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		
	}
	
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		searchBar.barTintColor = UIColor.brown
	}
}

extension OptionsListViewController: UIViewControllerTransitioningDelegate {
	func presentationController(forPresented presented: UIViewController,
								presenting: UIViewController?,
								source: UIViewController) -> UIPresentationController? {
		return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
	}
	
	func animationController(forPresented presented: UIViewController,
							 presenting: UIViewController,
							 source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return BounceAnimationController()
	}
	
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return FadeOutAnimationController()
	}
}

extension OptionsListViewController: UIGestureRecognizerDelegate {
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
						   shouldReceive touch: UITouch) -> Bool {
		return (touch.view === self.view)
	}
}
