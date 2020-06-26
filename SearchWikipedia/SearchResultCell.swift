//
//  SearchResultCell.swift
//  SearchWikipedia
//
//  Created by nolbal_dayeon on 2020/06/26.
//  Copyright © 2020 dayeonJung. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var lbWord: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
