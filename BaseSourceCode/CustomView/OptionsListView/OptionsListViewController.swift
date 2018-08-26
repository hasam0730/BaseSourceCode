
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
	@IBOutlet weak var containerView: UIView!
	@IBOutlet weak var searchBar: UISearchBar!
	var stringList: [String]!
	var filteredList: [String]!
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
		tableView.register(NoResultCell.self)
		//
		let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(close))
		gestureRecognizer.cancelsTouchesInView = false
		gestureRecognizer.delegate = self
		view.addGestureRecognizer(gestureRecognizer)
		
		//
		containerView.layer.cornerRadius = 5.0
		containerView.layer.masksToBounds = true
		//
		filteredList = stringList
		//
		tableView.tableFooterView = UIView()
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
		guard filteredList.count != 0 else {
			tableView.allowsSelection = false
			tableView.separatorStyle = .none
			return 1
		}
		tableView.allowsSelection = true
		tableView.separatorStyle = .singleLine
		return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if filteredList.count == 0 {
			let cell = tableView.dequeue(NoResultCell.self, for: indexPath)
			return cell
		}
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = filteredList[indexPath.row]
        return cell!
    }
}

extension OptionsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelect?(filteredList[indexPath.row])
    }
}

extension OptionsListViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText == "" {
			filteredList = stringList
		} else {
			filteredList = stringList.filter({
				return $0.lowercased().trim().contains(searchText.lowercased().trim())
			})
		}
		tableView.reloadData()
	}
	
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		
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
		return SlideOutAnimationController()
	}
}

extension OptionsListViewController: UIGestureRecognizerDelegate {
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
						   shouldReceive touch: UITouch) -> Bool {
		return (touch.view === self.view)
	}
}


class NoResultCell: UITableViewCell {
	override func awakeFromNib() {
		super.awakeFromNib()

	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		let label = UILabel(frame: contentView.frame)
		label.frame.origin.y += 20
		label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
		label.textColor = UIColor.gray
		label.text = "No Result"
		label.textAlignment = .center
		contentView.addSubview(label)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
