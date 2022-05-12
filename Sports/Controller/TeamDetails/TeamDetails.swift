//
//  TeamDetails.swift
//  Sports
//
//  Created by Walid Zain on 07/05/2022.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit
import SDWebImage
class TeamDetails: UIViewController {
    
    @IBOutlet weak var stadiumImage: UIImageView!
    @IBOutlet weak var teamImageView: UIImageView!
    
    @IBOutlet weak var stadiumNameLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    @IBOutlet weak var countryNameLabel: UILabel!
    
    @IBOutlet weak var foundYearLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var websiteLabel: UILabel!
    
    @IBOutlet weak var facebookLabel: UILabel!
    
    @IBOutlet weak var instagramLabel: UILabel!
    
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var youtubeLabel: UILabel!
    
    @IBOutlet weak var facebookIcon: UIImageView!
    
    @IBOutlet weak var websiteIcon: UIImageView!
    
    @IBOutlet weak var instagramIcon: UIImageView!
    
    @IBOutlet weak var twitterIcon: UIImageView!
    
    @IBOutlet weak var youtubeIcon: UIImageView!
    
    @IBOutlet weak var openWebsiteBtn: UIButton!
    
    @IBOutlet weak var openFacebookBtn: UIButton!
    
    @IBOutlet weak var openInstagramBtn: UIButton!
    
    @IBOutlet weak var openTwitterBtn: UIButton!
    
    @IBOutlet weak var openYoutubeBtn: UIButton!
    
    
    
    
    
    var selectedTeam: Team?

    override func viewDidLoad() {
        super.viewDidLoad()
        teamImageView.layer.cornerRadius=50
        guard let selectedTeam = selectedTeam else {
            return
        }

        if selectedTeam.strStadiumThumb != nil{
        stadiumImage.sd_setImage(with: URL(string: selectedTeam.strStadiumThumb!), placeholderImage: UIImage(named: "stadium"))
        }else{
            stadiumImage.image =  UIImage(named:"stadium.jpg")
        }
        if selectedTeam.strTeamBadge != nil{
        teamImageView.sd_setImage(with: URL(string: selectedTeam.strTeamBadge!), placeholderImage: UIImage(named: "team"))
        }else{
            stadiumImage.image =  UIImage(named:"defaultclub.jpg")
        }
        
        teamNameLabel.text = "Name : ".appending(selectedTeam.strTeam ?? "")
        stadiumNameLabel.text="Stadium : ".appending( selectedTeam.strStadium ?? "")
        countryNameLabel.text="Country : ".appending(selectedTeam.strCountry ?? "")
        foundYearLabel.text=selectedTeam.intFormedYear
        descriptionLabel.text=selectedTeam.strDescriptionEN
        
        if  ((selectedTeam.strWebsite?.isEmpty) == true){
            
            setHidden(icon: websiteIcon,button:openWebsiteBtn, label: websiteLabel)
        }else {
            websiteLabel.text=selectedTeam.strWebsite}
        
        if  ((selectedTeam.strFacebook?.isEmpty) == true){
            setHidden(icon: facebookIcon,button: openFacebookBtn, label: facebookLabel)
        }else {
            facebookLabel.text=selectedTeam.strFacebook}
        
        if selectedTeam.strInstagram?.isEmpty==true{
          setHidden(icon: instagramIcon, button: openInstagramBtn,label: instagramLabel)
        }else{
            instagramLabel.text=selectedTeam.strInstagram}
        
        if selectedTeam.strTwitter?.isEmpty==true{
          setHidden(icon: twitterIcon, button: openTwitterBtn,label: twitterLabel)
        }else{
            twitterLabel.text=selectedTeam.strTwitter}
        
        if selectedTeam.strYoutube?.isEmpty == true{
            setHidden(icon: youtubeIcon,button: openYoutubeBtn,label: youtubeLabel)
        }else{
            youtubeLabel.text=selectedTeam.strYoutube}
    }

    
    @IBAction func openWebsiteButton(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            openWebview((selectedTeam?.strWebsite)!)
        case 2:
            openWebview((selectedTeam?.strFacebook)!)
        case 3:
            openWebview((selectedTeam?.strInstagram)!)
        case 4:
            openWebview((selectedTeam?.strTwitter)!)
        case 5:
            openWebview((selectedTeam?.strYoutube)!)
        default:
            openWebview("google.com")
        }
    }

    func setHidden(icon:UIImageView,button:UIButton,label:UILabel){
        icon.isHidden=true
        label.isHidden=true
        button.isHidden=true
    }
//    func openWebview(link:String){
//        guard let url = URL(string: link) else { return }
//        UIApplication.shared.open(url)
//    }
    
    func openWebview(_ urlString: String) {
        guard let url = URL(string:"https://".appending(urlString) ) else {
           // showInvalidUrlAlert()
            return
        }
        UIApplication.shared.open(url, completionHandler: { success in
            if success {
                print("opened")
            } else {
                print("failed")

            }
        })
    }
    
}

