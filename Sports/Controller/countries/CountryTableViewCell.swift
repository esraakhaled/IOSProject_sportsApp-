//
//  CountryTableViewCell.swift
//  Sports
//
//  Created by Mac on 5/4/22.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var countyrName: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        countryImage .layer.cornerRadius = countryImage.frame.height / 2

    }

}
