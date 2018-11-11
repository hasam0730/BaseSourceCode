//
//  SearchViewController.swift
//  BaseSourceCode
//
//  Created by Developer on 10/7/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

	var controladorDeBusca: UISearchController!
	
	var resultsTableViewController: ResultsTableViewController!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		resultsTableViewController = storyboard!.instantiateViewController(withIdentifier: "resultsTableViewController") as? ResultsTableViewController
		
		
		self.extendedLayoutIncludesOpaqueBars = true
		configurarControladorDeBusca()
		
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.view.setNeedsLayout() // force update layout
		navigationController?.view.layoutIfNeeded() // to fix height of the navigation bar
	}
	
	func configurarControladorDeBusca() {
		
		controladorDeBusca = UISearchController(searchResultsController: resultsTableViewController)
		controladorDeBusca.searchResultsUpdater = resultsTableViewController
		controladorDeBusca.dimsBackgroundDuringPresentation = true
		definesPresentationContext = true
		
		controladorDeBusca.loadViewIfNeeded()
		
		//Configura a barra do Controlador de busca
		controladorDeBusca.searchBar.delegate = resultsTableViewController
		controladorDeBusca.hidesNavigationBarDuringPresentation = false
		controladorDeBusca.searchBar.placeholder = "Search place"
		controladorDeBusca.searchBar.sizeToFit()
		controladorDeBusca.searchBar.barTintColor = navigationController?.navigationBar.barTintColor
		controladorDeBusca.searchBar.tintColor = self.view.tintColor
		
		//Adiciona a barra do Controlador de Busca a barra do navegador
		let v = UIView(frame: CGRect(x: 0, y: 10, width: UIScreen.main.bounds.width, height: 74.0))
		v.addSubview(controladorDeBusca.searchBar)
		navigationItem.titleView = v
	}
}


class ResizeSearchController: UISearchController {
	
}
