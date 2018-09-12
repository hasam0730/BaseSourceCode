//
//  LoadMoreViewController.swift
//  BaseSourceCode
//
//  Created by mac mini on 9/12/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class LoadMoreViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var array = Array(repeating: 2, count: 30)

    fileprivate var activityIndicator: LoadMoreActivityController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        activityIndicator = LoadMoreActivityController(tableView: tableView, spacingFromLastCell: 10, spacingFromLastCellWhenLoadMoreActionStart: 60)
    }
}

extension LoadMoreViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath)"
        return cell
    }
}

extension LoadMoreViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        activityIndicator.scrollViewDidScroll(scrollView: scrollView) {
            DispatchQueue.global(qos: .utility).async {
                for i in 0..<10 {
                    print("!!!!!!!!! \(i)")
                    self.array.append(i)
                }
                sleep(5)
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                    self?.activityIndicator.loadMoreActionFinshed(scrollView: scrollView)
                }
            }
        }
    }
}
