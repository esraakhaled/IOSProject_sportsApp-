//
//  AllSports.swift
//  Sports
//
//  Created by Doaa Essam on 5/1/22.
//  Copyright © 2022 iti. All rights reserved.
//

import Foundation

struct SportsJson :Codable {
    
    var sports : [sportse]
    
}
struct sportse : Codable {
    
    var idSport : String?
    var strSport : String?
    var strFormat : StrFormat?
    var strSportThumb :String?
   var  strSportIconGreen : String?
    var strSportDescription :String?
    
}


enum StrFormat: String, Codable {
    case eventSport = "EventSport"
    case teamvsTeam = "TeamvsTeam"
}
