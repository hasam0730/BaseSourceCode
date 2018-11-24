//
//  SearchViewController.swift
//  BaseSourceCode
//
//  Created by Developer on 10/7/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

	var searchController: UISearchController!
	
	var resultsTableViewController: ResultsTableViewController!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		resultsTableViewController = storyboard!.instantiateViewController(withIdentifier: "resultsTableViewController") as? ResultsTableViewController
		
		
		self.extendedLayoutIncludesOpaqueBars = true
		configurarControladorDeBusca()
		initSearchControl()
		
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.view.setNeedsLayout() // force update layout
		navigationController?.view.layoutIfNeeded() // to fix height of the navigation bar
	}
	
	func configurarControladorDeBusca() {
		
		searchController = UISearchController(searchResultsController: resultsTableViewController)
//		controladorDeBusca.searchResultsUpdater = resultsTableViewController
//		controladorDeBusca.dimsBackgroundDuringPresentation = true
//		definesPresentationContext = true
//
//		controladorDeBusca.loadViewIfNeeded()
//
//		//Configura a barra do Controlador de busca
//		controladorDeBusca.searchBar.delegate = resultsTableViewController
//		controladorDeBusca.hidesNavigationBarDuringPresentation = false
//		controladorDeBusca.searchBar.placeholder = "Search place"
//		controladorDeBusca.searchBar.sizeToFit()
//		controladorDeBusca.searchBar.barTintColor = navigationController?.navigationBar.barTintColor
//		controladorDeBusca.searchBar.tintColor = self.view.tintColor
//
//		//Adiciona a barra do Controlador de Busca a barra do navegador
//		let v = UIView(frame: CGRect(x: 0, y: 10, width: UIScreen.main.bounds.width, height: 44.0))
//		v.addSubview(controladorDeBusca.searchBar)
//		navigationItem.titleView = v
	}
	
	
	func initSearchControl() {
		let backItem: UIBarButtonItem = UIBarButtonItem(image:  UIImage(named: "btn_back"),
														style: .plain,
														target: self,
														action: #selector(didTapBackNavItem))
		
//		let placeholderAttributeString = NSAttributedString(
//			string: NSLocalizedString("home_search_placeholder", comment: ""),
//			attributes: [NSForegroundColorAttributeName: UIColor.gray,
//						 NSFontAttributeName: FontHandler.other(.installed(.MuliBold), .standard(.h2)).value])
//		searchController.searchResultsUpdater = self
//		searchController.searchBar.setAttributePlaceholder(attributeString: placeholderAttributeString)
		searchController.dimsBackgroundDuringPresentation = false
		searchController.hidesNavigationBarDuringPresentation = false
		searchController.delegate = self
		searchController.searchBar.searchBarStyle = .prominent
		searchController.searchBar.backgroundColor = .white
		searchController.searchBar.backgroundImage = UIImage()
//		searchController.searchBar.setSearchBarTextColor(color: UIColor.darkGray)
		searchController.searchBar.setImage(UIImage(named: "imgSideMenuSavedSearchNormal"), for: .search, state: .normal)
		searchController.searchBar.backgroundColor = UIColor.clear
		searchController.searchBar.showsCancelButton = true
		let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as! UITextField
		textFieldInsideSearchBar.leftViewMode = UITextFieldViewMode.never
//		textFieldInsideSearchBar.font = FontHandler.text.value
//		textFieldInsideSearchBar.attributedPlaceholder = placeholderAttributeString
		navigationItem.leftBarButtonItem = backItem
//		searchController.searchBar.delegate = self
		let searchBarContainer = SearchBarContainerView(customSearchBar: searchController.searchBar)
		searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
//		let searchBarContainer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
//		searchBarContainer.addSubview(searchController.searchBar)
		navigationItem.titleView = searchBarContainer
		self.definesPresentationContext = false
	}
	
	
	
	@objc func didTapBackNavItem() {
//		presenter?.didTapOutSide(searchText: self.searchController.searchBar.text ?? "")
	}
}


extension SearchViewController: UISearchControllerDelegate {
	
}

class ResizeSearchController: UISearchController {
	
}





class SearchBarContainerView: UIView {
	
	let searchBar: UISearchBar
	
	
	
	init(customSearchBar: UISearchBar) {
		searchBar = customSearchBar
		super.init(frame: CGRect.zero)
		addSubview(searchBar)
	}
	
	
	
	override convenience init(frame: CGRect) {
		self.init(customSearchBar: UISearchBar())
		self.frame = frame
	}
	
	
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	override func layoutSubviews() {
		super.layoutSubviews()
		searchBar.frame = bounds
	}
}
