//
//  countrys.swift
//  Sports
//
//  Created by Mac on 5/4/22.
//  Copyright © 2022 iti. All rights reserved.
//

import Foundation
struct  apiCallData: Codable{
    let countrys:[city]?
}
// MARK: - League
struct city: Codable {
    let idLeague:String?
    let strLeague, strBadge: String?
    let strYoutube: String?
    let strSport:String?
    let strCountry:String?
}
