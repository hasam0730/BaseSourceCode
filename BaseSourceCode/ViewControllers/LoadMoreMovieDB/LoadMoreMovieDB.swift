//
//  LoadMoreMovieDB.swift
//  BaseSourceCode
//
//  Created by Developer on 11/23/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit
import Alamofire

class LoadMoreMovieDB: ViewController {
	
	
	@IBOutlet weak var tableView: UITableView!
	
	fileprivate var activityIndicator: LoadMoreActivityController!
	var pageNumber: Int = 1
	var movieResponse: MovieResponse? {
		didSet {
			guard movieResponse != nil else { return }
			
		}
	}
	
	var movieList: [MovieEntity] = [] {
		didSet {
			tableView.reloadData()
		}
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.registerXibFile(TableViewCell.self)
		tableView.registerHeaderXibFile(TableViewHeader.self)
		fetchingMoviesList(at: pageNumber)
		
		activityIndicator = LoadMoreActivityController(
			tableView: tableView,
			spacingFromLastCell: 10,
			spacingFromLastCellWhenLoadMoreActionStart: 60)
		
	}
	
	func fetchingMoviesList(at page: Int) {
		NetworkManager.requestsObject(
			Router.theMovieDB(params: ["api_key": "806703be0a04ac4b63c9614ab481ed60",
									   "page": page])) { (rs: NetworkManager.ResultRequest<DataResponse<MovieResponse>>) in
							switch rs {
							case .success(let value):
								self.movieResponse = value.result.value
								self.movieList = value.result.value!.results
								self.pageNumber += 1
							case .failure(let error):
								print(error.localizedDescription)
							}
		}
	}
}


extension LoadMoreMovieDB: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return movieList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeue(TableViewCell.self, for: indexPath)
		let item = movieList[indexPath.row]
		cell.configCell(movie: item)
		return cell
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = tableView.dequeue(header: TableViewHeader.self)
		headerView.labelHeader.text = "🍏 \(movieResponse?.page)"
		return headerView
	}
}


extension LoadMoreMovieDB: UITableViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let  height = scrollView.frame.size.height
		let contentYoffset = scrollView.contentOffset.y
		let distanceFromBottom = scrollView.contentSize.height - contentYoffset
		if distanceFromBottom < height {
			activityIndicator.scrollViewDidScroll(scrollView: scrollView) {
				if self.pageNumber == movieResponse!.total_pages {
					DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000), execute: {
						self.activityIndicator.loadMoreActionFinshed(scrollView: scrollView)
						return
					})
				}
				
				NetworkManager.requestsObject(
					Router.theMovieDB(params: ["api_key": "806703be0a04ac4b63c9614ab481ed60",
											   "page": pageNumber])) { (rs: NetworkManager.ResultRequest<DataResponse<MovieResponse>>) in
												switch rs {
												case .success(let value):
//													self.movieResponse = value.result.value
													self.movieList += value.result.value!.results
													self.pageNumber += 1
													//												DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(3000), execute: {
													DispatchQueue.main.async { [weak self] in
														self?.activityIndicator.loadMoreActionFinshed(scrollView: scrollView)
														self?.tableView.reloadData()
													}
												//												})
												case .failure(let error):
													print(error.localizedDescription)
													DispatchQueue.main.async { [weak self] in
														self?.activityIndicator.loadMoreActionFinshed(scrollView: scrollView)
													}
												}
				}
		}
		
//			NewsEntity.fetchingNewsList(limit: limit, page: page) { [unowned self] newsItemsList, _, error in
//
//				if let err = error {
//					MyAlertController.showAlert(message: err.localizedDescription)
//				} else if let uwrDataList = newsItemsList {
//
//					if uwrDataList.count > 0 {
//						self.page+=1
//						self.newsItemsList! += uwrDataList
//						DispatchQueue.main.async { [weak self] in
//							self?.activityIndicator.loadMoreActionFinshed(scrollView: scrollView)
//							self?.tableView.reloadData()
//						}
//						LOADING_HELPER.dismissProgressHUD()
//					}
//				}
//			}
		}
	}
}

