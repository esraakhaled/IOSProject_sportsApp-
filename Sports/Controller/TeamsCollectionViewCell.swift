
//
//  TeamsCollectionViewCell.swift
//  Sports
//
//  Created by yasmeen hosny on 5/3/22.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit

class TeamsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamLogu: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
}


extension UIImageView {
   func setImageViewRounded() {
    let radius = self.frame.width / 2
      self.layer.cornerRadius = radius
      self.layer.masksToBounds = true
   }
}
