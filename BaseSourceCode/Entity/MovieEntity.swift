//
//  MovieEntity.swift
//  BaseSourceCode
//
//  Created by Developer on 11/24/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

struct MovieResponse: ResponseObjectSerializable, ResponseCollectionSerializable {
	var results: [MovieEntity]
	var page: Int
	var total_results: Int
	var total_pages: Int
}

extension MovieResponse {
	init?(response: HTTPURLResponse, representation: Any) {
		guard let representation 	= representation 					as? [String: Any],
		let results 				= representation["results"],
		let page 					= representation["page"] 			as? Int,
		let total_results			= representation["total_results"] 	as? Int,
		let total_pages 			= representation["total_pages"] 	as? Int else { return nil }
		
		self.results = MovieEntity.collection(from: response, withRepresentation: results)
		self.page = page
		self.total_pages = total_pages
		self.total_results = total_results
	}
}


struct MovieEntity: ResponseObjectSerializable, ResponseCollectionSerializable {
	var vote_count: Int
	var id: Int
	var vote_average: Double
	var title: String
	var popularity: Double
	var poster_path: String
	var originalTitle: String
	var release_date: String
}

extension MovieEntity {
	
	init?(response: HTTPURLResponse, representation: Any) {
		guard
			let representation 	= representation 					as? [String: Any],
			let vote_count 		= representation["vote_count"] 		as? Int,
			let id 				= representation["id"] 				as? Int,
			let vote_average 	= representation["vote_average"] 	as? Double,
			let title 			= representation["title"] 			as? String,
			let popularity 		= representation["popularity"] 		as? Double,
			let poster_path 	= representation["poster_path"] 	as? String,
			let originalTitle 	= representation["original_title"] 	as? String,
			let release_date 	= representation["release_date"] 	as? String else { return nil }
		
		self.vote_count 	= vote_count
		self.id 			= id
		self.vote_average 	= vote_average
		self.title 			= title
		self.popularity 	= popularity
		self.poster_path 	= poster_path
		self.originalTitle 	= originalTitle
		self.release_date 	= release_date
	}
}
