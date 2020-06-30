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
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var btnRight: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    
    
    func setSearchingResultUI(input: String, searchResult: String) {
        self.lbDate.isHidden = true
        
        if searchResult.contains(input) {
            let hilightedStr = NSMutableAttributedString(string: searchResult)
            
            hilightedStr.addAttributes([.font:UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.orange],
                                         range: (searchResult as NSString).range(of: input))
            
            self.lbWord.attributedText = hilightedStr
        } else {
            self.lbWord.text = searchResult
        }
        
    }
    
    
    func setRecentSearchingRecordUI(record: SearchRecordModel) {
        self.lbDate.isHidden = false

        self.lbWord.text = record.searchingWord
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd HH:mm"
        
        self.lbDate.text = dateFormatter.string(from: record.date)
    }
    
    
}
