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
 
    
    func setUI(input: String, searchResult: String) {
        
        if searchResult.contains(input) {
            let hilightedStr = NSMutableAttributedString(string: searchResult)
            
            hilightedStr.addAttributes([.font:UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.orange],
                                         range: (searchResult as NSString).range(of: input))
            
            self.lbWord.attributedText = hilightedStr
        } else {
            self.lbWord.text = searchResult
        }
        
    }
    
}
