//
//  SportsCollectionViewCell.swift
//  Sports
//
//  Created by Doaa Essam on 5/1/22.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit

class SportsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sportsImage: UIImageView!
    
    @IBOutlet weak var sportsName: UILabel!
    
    
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.containerView.layer.cornerRadius = 20
        self.containerView.layer.borderWidth = 0.5
        self.containerView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
   
}
