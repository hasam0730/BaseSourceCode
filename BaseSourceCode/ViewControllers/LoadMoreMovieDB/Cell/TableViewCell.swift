//
//  TableViewCell.swift
//  BaseSourceCode
//
//  Created by Developer on 11/23/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

	@IBOutlet weak var titleLbl: UILabel!
	@IBOutlet weak var originalTitleLbl: UILabel!
	@IBOutlet weak var idLbl: UILabel!
	@IBOutlet weak var popularityLbl: UILabel!
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func configCell(movie: MovieEntity?) {
		guard let movie = movie else { return }
		titleLbl.text = movie.title
		originalTitleLbl.text = movie.originalTitle
		idLbl.text = "\(movie.id)"
		popularityLbl.text = "\(movie.popularity)".formatDecimalNumber()
	}
    
}
