//
//  LeagueCustomCell.swift
//  Sports
//
//  Created by Esraa Khaled   on 04/05/2022.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit

class LeagueCustomCell: UITableViewCell {

    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leaugeName: UILabel!
    @IBOutlet weak var youtubeBtn: UIButton!
    var youtube:String!{
        didSet{
            if youtube != ""{
                youtubeBtn.isHidden = false
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func openYoutube(_ sender: Any) {
        print(youtube! as Any)
        if youtube! != ""{
            
            if let youtubeURL = URL(string: "https://\(youtube!)"),
                UIApplication.shared.canOpenURL(youtubeURL) {
                // redirect to app
                UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
            } else if let youtubeURL = URL(string: "https://\(youtube!)") {
                // redirect through safari
                UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
            }
        }
    }
}

