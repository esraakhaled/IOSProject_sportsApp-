//
//  Teams.swift
//  Sports
//
//  Created by Mac on 5/9/22.
//  Copyright © 2022 iti. All rights reserved.
//

import Foundation


struct TeamsResponse: Codable {
    var teams: [Team]
}

struct Team: Codable {
    let idTeam:String
    let strTeam:String?
    let strSport: String?
    let strLeague:String?
    let strCountry: String?
    let intFormedYear:String?
    let strWebsite:String?
    let strFacebook:String?
    let strTwitter:String?
    let strInstagram:String?
    let strDescriptionEN:String?
    let strYoutube:String?
    let strTeamBadge:String?
    let strTeamFanart1:String?
    let strStadium:String?
    let strStadiumThumb:String?
}
