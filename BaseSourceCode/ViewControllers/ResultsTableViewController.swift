//
//  ResultsTableViewController.swift
//  BaseSourceCode
//
//  Created by Developer on 10/7/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {

	var array = ["Brazil", "Bolivia", "United States", "Canada", "England", "Germany", "France", "Portugal"]
	var arrayFilter: [String] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return arrayFilter.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
		
		cell.textLabel?.text = arrayFilter[indexPath.row]
		
		return cell
	}
	
	
	func updateSearchResults(for searchController: UISearchController) {
		
		
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		
		arrayFilter.removeAll()
		
		if let text = searchBar.text {
			for string in array {
				if string.contains(text) {
					arrayFilter.append(string)
				}
			}
		}
		
		tableView.reloadData()
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		
		arrayFilter.removeAll()
		tableView.reloadData()
	}
	
	func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
		
		arrayFilter.removeAll()
		tableView.reloadData()
		
		return true
	}
}
