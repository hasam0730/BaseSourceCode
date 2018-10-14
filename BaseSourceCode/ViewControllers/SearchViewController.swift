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
		navigationItem.titleView = controladorDeBusca.searchBar
	}
}


class ResizeSearchController: UISearchController {
	
}
