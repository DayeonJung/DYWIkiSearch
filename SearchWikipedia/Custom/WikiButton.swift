//
//  WikiButton.swift
//  SearchWikipedia
//
//  Created by Dayeon Jung on 2020/07/02.
//  Copyright © 2020 dayeonJung. All rights reserved.
//


import UIKit

@IBDesignable
class WikiButton: UIButton {

     
    // MARK: - Variables
    public var onClick = { () }
    

    
    // MARK: - init methods
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        
    }
    
    // MARK: - Update UI
    private func updateUI() {
        addTarget(self, action: #selector(clickAction(button:)), for: .touchUpInside)
    }

    
    // MARK: - On Click
    @objc private func clickAction(button: UIButton) {
        onClick()
    }

}
